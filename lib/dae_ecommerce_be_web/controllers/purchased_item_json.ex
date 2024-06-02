defmodule DaeEcommerceBeWeb.PurchasedItemJSON do
  alias DaeEcommerceBe.PurchasedItems.PurchasedItem

  @doc """
  Renders a list of purchased_items.
  """
  def index(%{purchased_items: purchased_items}) do
    %{data: for(purchased_item <- purchased_items, do: data(purchased_item))}
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
end
