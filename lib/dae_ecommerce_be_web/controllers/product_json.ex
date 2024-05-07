defmodule DaeEcommerceBeWeb.ProductJSON do
  alias DaeEcommerceBe.Products.Product

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{data: for(product <- products, do: data(product))}
  end

  @doc """
  Renders a single product.
  """
  def show(%{product: product}) do
    %{data: data(product)}
  end

  def show_with_images(%{product: product}) do
    %{
      id: product.id,
      title: product.title,
      description: product.description,
      is_disabled: product.is_disabled,
      current_price: product.current_price,
      previous_price: product.previous_price,
      tags: product.tags,
      product_images:
        for(
          product_image <- product.product_images,
          do: DaeEcommerceBeWeb.ProductImageJSON.data_simple(product_image)
        )
    }
  end

  defp data(%Product{} = product) do
    %{
      id: product.id,
      title: product.title,
      description: product.description,
      is_disabled: product.is_disabled,
      current_price: product.current_price,
      previous_price: product.previous_price,
      tags: product.tags
    }
  end
end
