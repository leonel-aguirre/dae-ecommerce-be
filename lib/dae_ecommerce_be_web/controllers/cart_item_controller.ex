defmodule DaeEcommerceBeWeb.CartItemController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.Products
  alias DaeEcommerceBe.CartItems
  alias DaeEcommerceBe.CartItems.CartItem

  action_fallback DaeEcommerceBeWeb.FallbackController

  def item_amount(conn, _params) do
    user_id = conn.assigns.account.user.id

    cart_items_amount = CartItems.get_amount(user_id)

    IO.inspect(cart_items_amount)

    conn
    |> put_status(200)
    |> json(%{data: cart_items_amount})
  end

  def all_items(conn, _params) do
    user_id = conn.assigns.account.user.id

    cart_items = CartItems.list_cart_items_by_user_id(user_id)

    render(conn, :index, cart_items: cart_items)
  end

  def add_item(conn, %{"product_id" => product_id}) do
    user_id = conn.assigns.account.user.id
    product = Products.get_product!(product_id)

    with {:ok, %CartItem{} = cart_item} <-
           CartItems.create_cart_item(conn.assigns.account.user, product, %{
             user_id: user_id,
             product_id: product_id
           }) do
      conn
      |> put_status(:created)
      |> render(:show, cart_item: cart_item)
    end
  end

  def index(conn, _params) do
    cart_items = CartItems.list_cart_items()
    render(conn, :index, cart_items: cart_items)
  end

  def delete(conn, %{"cart_item_id" => cart_item_id}) do
    IO.inspect(cart_item_id)

    cart_item = CartItems.get_cart_item!(cart_item_id)

    with {:ok, %CartItem{}} <- CartItems.delete_cart_item(cart_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
