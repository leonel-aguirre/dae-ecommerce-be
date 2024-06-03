defmodule DaeEcommerceBeWeb.PurchasedItemJSON do
  alias DaeEcommerceBe.PurchasedItems.PurchasedItem

  @doc """
  Renders a list of purchased_items.
  """
  def index(%{purchased_items: purchased_items}) do
    %{data: for(purchased_item <- purchased_items, do: data(purchased_item))}
  end

  def index_with_publish_date(%{purchased_items: purchased_items}) do
    %{data: for(purchased_item <- purchased_items, do: data_with_publish_date(purchased_item))}
  end

  @doc """
  Renders a single purchased_item.
  """
  def show(%{purchased_item: purchased_item}) do
    %{data: data(purchased_item)}
  end

  defp data(%PurchasedItem{} = purchased_item) do
    %{
      id: purchased_item.id
    }
  end

  defp data_with_publish_date(%PurchasedItem{} = purchased_item) do
    %{
      id: purchased_item.id,
      purchase_date: purchased_item.inserted_at,
      product: DaeEcommerceBeWeb.ProductJSON.index_with_images(purchased_item.product)
    }
  end
end
