defmodule DaeEcommerceBeWeb.PurchasedItemController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.PurchasedItems
  alias DaeEcommerceBe.PurchasedItems.PurchasedItem

  action_fallback DaeEcommerceBeWeb.FallbackController

  def index(conn, _params) do
    purchased_items = PurchasedItems.list_purchased_items()
    render(conn, :index, purchased_items: purchased_items)
  end

  def create(conn, %{"purchased_item" => purchased_item_params}) do
    with {:ok, %PurchasedItem{} = purchased_item} <- PurchasedItems.create_purchased_item(purchased_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/purchased_items/#{purchased_item}")
      |> render(:show, purchased_item: purchased_item)
    end
  end

  def show(conn, %{"id" => id}) do
    purchased_item = PurchasedItems.get_purchased_item!(id)
    render(conn, :show, purchased_item: purchased_item)
  end

  def update(conn, %{"id" => id, "purchased_item" => purchased_item_params}) do
    purchased_item = PurchasedItems.get_purchased_item!(id)

    with {:ok, %PurchasedItem{} = purchased_item} <- PurchasedItems.update_purchased_item(purchased_item, purchased_item_params) do
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
