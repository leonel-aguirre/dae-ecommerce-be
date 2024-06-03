defmodule DaeEcommerceBeWeb.PurchasedItemController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.CartItems
  alias DaeEcommerceBe.Products
  alias DaeEcommerceBe.PurchasedItems
  alias DaeEcommerceBe.PurchasedItems.PurchasedItem

  action_fallback DaeEcommerceBeWeb.FallbackController

  def purchase_items(conn, %{"cart_item_ids" => cart_item_ids}) do
    user_id = conn.assigns.account.user.id

    purchased_items =
      cart_item_ids
      |> Enum.reduce([], fn cart_item_id, acc ->
        cart_item = CartItems.get_cart_item!(cart_item_id)
        product_id = cart_item.product_id
        product = Products.get_product!(product_id)

        case PurchasedItems.add_purchased_items(conn.assigns.account.user, product, %{
               user_id: user_id,
               product_id: product_id
             }) do
          {:ok, %PurchasedItem{} = purchased_item} ->
            CartItems.delete_cart_item(cart_item)
            [purchased_item | acc]

          {:error, _reason} ->
            acc
        end
      end)

    conn
    |> put_status(:created)
    |> render(:index, purchased_items: purchased_items)
  end

  def get_user_purchased_items(conn, _params) do
    user_id = conn.assigns.account.user.id

    purchased_items = PurchasedItems.list_user_purchased_items(user_id)

    render(conn, :index_with_publish_date, purchased_items: purchased_items)
  end

  def index(conn, _params) do
    purchased_items = PurchasedItems.list_purchased_items()

    render(conn, :index, purchased_items: purchased_items)
  end

  def create(conn, %{"purchased_item" => purchased_item_params}) do
    with {:ok, %PurchasedItem{} = purchased_item} <-
           PurchasedItems.create_purchased_item(purchased_item_params) do
      conn
      |> put_status(:created)
      |> render(:show, purchased_item: purchased_item)
    end
  end

  def show(conn, %{"id" => id}) do
    purchased_item = PurchasedItems.get_purchased_item!(id)
    render(conn, :show, purchased_item: purchased_item)
  end

  def update(conn, %{"id" => id, "purchased_item" => purchased_item_params}) do
    purchased_item = PurchasedItems.get_purchased_item!(id)

    with {:ok, %PurchasedItem{} = purchased_item} <-
           PurchasedItems.update_purchased_item(purchased_item, purchased_item_params) do
      render(conn, :show, purchased_item: purchased_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    purchased_item = PurchasedItems.get_purchased_item!(id)

    with {:ok, %PurchasedItem{}} <- PurchasedItems.delete_purchased_item(purchased_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
