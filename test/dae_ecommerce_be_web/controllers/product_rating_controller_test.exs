defmodule DaeEcommerceBeWeb.ProductRatingControllerTest do
  use DaeEcommerceBeWeb.ConnCase

  import DaeEcommerceBe.ProductRatingsFixtures

  alias DaeEcommerceBe.ProductRatings.ProductRating

  @create_attrs %{
    rating: 120.5
  }
  @update_attrs %{
    rating: 456.7
  }
  @invalid_attrs %{rating: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all product_ratings", %{conn: conn} do
      conn = get(conn, ~p"/api/product_ratings")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product_rating" do
    test "renders product_rating when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/product_ratings", product_rating: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/product_ratings/#{id}")

      assert %{
               "id" => ^id,
               "rating" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/product_ratings", product_rating: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product_rating" do
    setup [:create_product_rating]

    test "renders product_rating when data is valid", %{conn: conn, product_rating: %ProductRating{id: id} = product_rating} do
      conn = put(conn, ~p"/api/product_ratings/#{product_rating}", product_rating: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/product_ratings/#{id}")

      assert %{
               "id" => ^id,
               "rating" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product_rating: product_rating} do
      conn = put(conn, ~p"/api/product_ratings/#{product_rating}", product_rating: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product_rating" do
    setup [:create_product_rating]

    test "deletes chosen product_rating", %{conn: conn, product_rating: product_rating} do
      conn = delete(conn, ~p"/api/product_ratings/#{product_rating}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/product_ratings/#{product_rating}")
      end
    end
  end

  defp create_product_rating(_) do
    product_rating = product_rating_fixture()
    %{product_rating: product_rating}
  end
end
