defmodule DaeEcommerceBeWeb.ProductImageJSON do
  alias DaeEcommerceBe.ProductImages.ProductImage

  @doc """
  Renders a list of product_images.
  """
  def index(%{product_images: product_images}) do
    %{data: for(product_image <- product_images, do: data(product_image))}
  end

  @doc """
  Renders a single product_image.
  """
  def show(%{product_image: product_image}) do
    %{data: data(product_image)}
  end

  defp data(%ProductImage{} = product_image) do
    %{
      id: product_image.id,
      data: product_image.data
    }
  end

  def data_simple(%ProductImage{} = product_image) do
    %{
      id: product_image.id
    }
  end
end
