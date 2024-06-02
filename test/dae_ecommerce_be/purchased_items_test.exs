defmodule DaeEcommerceBe.PurchasedItemsTest do
  use DaeEcommerceBe.DataCase

  alias DaeEcommerceBe.PurchasedItems

  describe "purchased_items" do
    alias DaeEcommerceBe.PurchasedItems.PurchasedItem

    import DaeEcommerceBe.PurchasedItemsFixtures

    @invalid_attrs %{}

    test "list_purchased_items/0 returns all purchased_items" do
      purchased_item = purchased_item_fixture()
      assert PurchasedItems.list_purchased_items() == [purchased_item]
    end

    test "get_purchased_item!/1 returns the purchased_item with given id" do
      purchased_item = purchased_item_fixture()
      assert PurchasedItems.get_purchased_item!(purchased_item.id) == purchased_item
    end

    test "create_purchased_item/1 with valid data creates a purchased_item" do
      valid_attrs = %{}

      assert {:ok, %PurchasedItem{} = purchased_item} = PurchasedItems.create_purchased_item(valid_attrs)
    end

    test "create_purchased_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PurchasedItems.create_purchased_item(@invalid_attrs)
    end

    test "update_purchased_item/2 with valid data updates the purchased_item" do
      purchased_item = purchased_item_fixture()
      update_attrs = %{}

      assert {:ok, %PurchasedItem{} = purchased_item} = PurchasedItems.update_purchased_item(purchased_item, update_attrs)
    end

    test "update_purchased_item/2 with invalid data returns error changeset" do
      purchased_item = purchased_item_fixture()
      assert {:error, %Ecto.Changeset{}} = PurchasedItems.update_purchased_item(purchased_item, @invalid_attrs)
      assert purchased_item == PurchasedItems.get_purchased_item!(purchased_item.id)
    end

    test "delete_purchased_item/1 deletes the purchased_item" do
      purchased_item = purchased_item_fixture()
      assert {:ok, %PurchasedItem{}} = PurchasedItems.delete_purchased_item(purchased_item)
      assert_raise Ecto.NoResultsError, fn -> PurchasedItems.get_purchased_item!(purchased_item.id) end
    end

    test "change_purchased_item/1 returns a purchased_item changeset" do
      purchased_item = purchased_item_fixture()
      assert %Ecto.Changeset{} = PurchasedItems.change_purchased_item(purchased_item)
    end
  end
end
