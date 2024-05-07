defmodule DaeEcommerceBeWeb.ProductControllerTest do
  use DaeEcommerceBeWeb.ConnCase

  import DaeEcommerceBe.ProductsFixtures

  alias DaeEcommerceBe.Products.Product

  @create_attrs %{
    description: "some description",
    title: "some title",
    is_disabled: true,
    current_price: 120.5,
    previous_price: 120.5,
    tags: ["option1", "option2"]
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    is_disabled: false,
    current_price: 456.7,
    previous_price: 456.7,
    tags: ["option1"]
  }
  @invalid_attrs %{description: nil, title: nil, is_disabled: nil, current_price: nil, previous_price: nil, tags: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, ~p"/api/products")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/products", product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/products/#{id}")

      assert %{
               "id" => ^id,
               "current_price" => 120.5,
               "description" => "some description",
               "is_disabled" => true,
               "previous_price" => 120.5,
               "tags" => ["option1", "option2"],
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/products", product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, ~p"/api/products/#{product}", product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/products/#{id}")

      assert %{
               "id" => ^id,
               "current_price" => 456.7,
               "description" => "some updated description",
               "is_disabled" => false,
               "previous_price" => 456.7,
               "tags" => ["option1"],
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, ~p"/api/products/#{product}", product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, ~p"/api/products/#{product}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/products/#{product}")
      end
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
