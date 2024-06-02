defmodule DaeEcommerceBeWeb.ProductRatingController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.ProductRatings
  alias DaeEcommerceBe.ProductRatings.ProductRating

  action_fallback DaeEcommerceBeWeb.FallbackController

  def index(conn, _params) do
    product_ratings = ProductRatings.list_product_ratings()
    render(conn, :index, product_ratings: product_ratings)
  end

  def create(conn, %{"product_rating" => product_rating_params}) do
    with {:ok, %ProductRating{} = product_rating} <- ProductRatings.create_product_rating(product_rating_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/product_ratings/#{product_rating}")
      |> render(:show, product_rating: product_rating)
    end
  end

  def show(conn, %{"id" => id}) do
    product_rating = ProductRatings.get_product_rating!(id)
    render(conn, :show, product_rating: product_rating)
  end

  def update(conn, %{"id" => id, "product_rating" => product_rating_params}) do
    product_rating = ProductRatings.get_product_rating!(id)

    with {:ok, %ProductRating{} = product_rating} <- ProductRatings.update_product_rating(product_rating, product_rating_params) do
      render(conn, :show, product_rating: product_rating)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_rating = ProductRatings.get_product_rating!(id)

    with {:ok, %ProductRating{}} <- ProductRatings.delete_product_rating(product_rating) do
      send_resp(conn, :no_content, "")
    end
  end
end
