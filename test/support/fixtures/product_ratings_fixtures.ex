defmodule DaeEcommerceBe.ProductRatingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.ProductRatings` context.
  """

  @doc """
  Generate a product_rating.
  """
  def product_rating_fixture(attrs \\ %{}) do
    {:ok, product_rating} =
      attrs
      |> Enum.into(%{
        rating: 120.5
      })
      |> DaeEcommerceBe.ProductRatings.create_product_rating()

    product_rating
  end
end
