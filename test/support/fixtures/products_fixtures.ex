defmodule DaeEcommerceBe.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        current_price: 120.5,
        description: "some description",
        is_disabled: true,
        previous_price: 120.5,
        tags: ["option1", "option2"],
        title: "some title"
      })
      |> DaeEcommerceBe.Products.create_product()

    product
  end
end
