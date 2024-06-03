defmodule DaeEcommerceBe.ProductImagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.ProductImages` context.
  """

  @doc """
  Generate a product_image.
  """
  def product_image_fixture(attrs \\ %{}) do
    {:ok, product_image} =
      attrs
      |> Enum.into(%{
        data: "some data"
      })
      |> DaeEcommerceBe.ProductImages.create_product_image()

    product_image
  end
end
