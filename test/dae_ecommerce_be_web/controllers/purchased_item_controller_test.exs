defmodule DaeEcommerceBeWeb.PurchasedItemControllerTest do
  use DaeEcommerceBeWeb.ConnCase

  import DaeEcommerceBe.PurchasedItemsFixtures

  alias DaeEcommerceBe.PurchasedItems.PurchasedItem

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all purchased_items", %{conn: conn} do
      conn = get(conn, ~p"/api/purchased_items")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create purchased_item" do
    test "renders purchased_item when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/purchased_items", purchased_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/purchased_items/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/purchased_items", purchased_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update purchased_item" do
    setup [:create_purchased_item]

    test "renders purchased_item when data is valid", %{conn: conn, purchased_item: %PurchasedItem{id: id} = purchased_item} do
      conn = put(conn, ~p"/api/purchased_items/#{purchased_item}", purchased_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/purchased_items/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, purchased_item: purchased_item} do
      conn = put(conn, ~p"/api/purchased_items/#{purchased_item}", purchased_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete purchased_item" do
    setup [:create_purchased_item]

    test "deletes chosen purchased_item", %{conn: conn, purchased_item: purchased_item} do
      conn = delete(conn, ~p"/api/purchased_items/#{purchased_item}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/purchased_items/#{purchased_item}")
      end
    end
  end

  defp create_purchased_item(_) do
    purchased_item = purchased_item_fixture()
    %{purchased_item: purchased_item}
  end
end
