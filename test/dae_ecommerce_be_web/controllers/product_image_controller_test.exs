defmodule DaeEcommerceBeWeb.ProductImageControllerTest do
  use DaeEcommerceBeWeb.ConnCase

  import DaeEcommerceBe.ProductImagesFixtures

  alias DaeEcommerceBe.ProductImages.ProductImage

  @create_attrs %{
    data: "some data"
  }
  @update_attrs %{
    data: "some updated data"
  }
  @invalid_attrs %{data: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all product_images", %{conn: conn} do
      conn = get(conn, ~p"/api/product_images")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product_image" do
    test "renders product_image when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/product_images", product_image: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/product_images/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some data"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/product_images", product_image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product_image" do
    setup [:create_product_image]

    test "renders product_image when data is valid", %{conn: conn, product_image: %ProductImage{id: id} = product_image} do
      conn = put(conn, ~p"/api/product_images/#{product_image}", product_image: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/product_images/#{id}")

      assert %{
               "id" => ^id,
               "data" => "some updated data"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product_image: product_image} do
      conn = put(conn, ~p"/api/product_images/#{product_image}", product_image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product_image" do
    setup [:create_product_image]

    test "deletes chosen product_image", %{conn: conn, product_image: product_image} do
      conn = delete(conn, ~p"/api/product_images/#{product_image}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/product_images/#{product_image}")
      end
    end
  end

  defp create_product_image(_) do
    product_image = product_image_fixture()
    %{product_image: product_image}
  end
end
