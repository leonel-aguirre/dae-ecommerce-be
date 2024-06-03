defmodule DaeEcommerceBeWeb.CartItemJSON do
  alias DaeEcommerceBe.CartItems.CartItem

  @doc """
  Renders a list of cart_items.
  """
  def index(%{cart_items: cart_items}) do
    %{data: for(cart_item <- cart_items, do: index_with_product(cart_item))}
  end

  def index_with_product(%CartItem{} = cart_item) do
    %{
      id: cart_item.id,
      product: DaeEcommerceBeWeb.ProductJSON.index_with_images(cart_item.product)
    }
  end

  @doc """
  Renders a single cart_item.
  """
  def show(%{cart_item: cart_item}) do
    %{data: data(cart_item)}
  end

  defp data(%CartItem{} = cart_item) do
    %{
      id: cart_item.id
    }
  end
end
