defmodule DaeEcommerceBe.CartItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.CartItems` context.
  """

  @doc """
  Generate a cart_item.
  """
  def cart_item_fixture(attrs \\ %{}) do
    {:ok, cart_item} =
      attrs
      |> Enum.into(%{

      })
      |> DaeEcommerceBe.CartItems.create_cart_item()

    cart_item
  end
end
