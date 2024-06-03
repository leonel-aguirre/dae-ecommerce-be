defmodule DaeEcommerceBe.PurchasedItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.PurchasedItems` context.
  """

  @doc """
  Generate a purchased_item.
  """
  def purchased_item_fixture(attrs \\ %{}) do
    {:ok, purchased_item} =
      attrs
      |> Enum.into(%{

      })
      |> DaeEcommerceBe.PurchasedItems.create_purchased_item()

    purchased_item
  end
end
