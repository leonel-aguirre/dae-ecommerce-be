defmodule DaeEcommerceBeWeb.ProductRatingController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.PurchasedItems
  alias DaeEcommerceBe.Products
  alias DaeEcommerceBe.ProductRatings
  alias DaeEcommerceBe.ProductRatings.ProductRating

  action_fallback DaeEcommerceBeWeb.FallbackController

  def index(conn, _params) do
    product_ratings = ProductRatings.list_product_ratings()
    render(conn, :index, product_ratings: product_ratings)
  end

  def create(conn, %{"product_id" => product_id, "rating" => rating}) do
    user_id = conn.assigns.account.user.id

    has_user_purchased_product = PurchasedItems.has_user_purchased_product(user_id, product_id)

    if has_user_purchased_product do
      product = Products.get_product!(product_id)

      with {:ok, %ProductRating{} = product_rating} <-
             ProductRatings.add_product_rating(conn.assigns.account.user, product, %{
               user_id: user_id,
               product_id: product_id,
               rating: rating
             }) do
        conn
        |> put_status(:created)
        |> render(:show, product_rating: product_rating)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{success: false, message: "Unable to rate a non purchased product."})
    end
  end

  def user_rated_product(conn, %{"product_id" => product_id}) do
    user_id = conn.assigns.account.user.id

    user_rated_product = ProductRatings.get_user_rated_product(user_id, product_id)

    conn
    |> put_status(200)
    |> render(:show, product_rating: user_rated_product)
  end

  def user_rated_products(conn, _params) do
    user_id = conn.assigns.account.user.id

    product_ratings = ProductRatings.get_user_rated_product(user_id)

    conn
    |> put_status(200)
    |> render(:index, product_ratings: product_ratings)
  end

  def show(conn, %{"id" => id}) do
    product_rating = ProductRatings.get_product_rating!(id)
    render(conn, :show, product_rating: product_rating)
  end

  def update(conn, %{"id" => id, "product_rating" => product_rating_params}) do
    product_rating = ProductRatings.get_product_rating!(id)

    with {:ok, %ProductRating{} = product_rating} <-
           ProductRatings.update_product_rating(product_rating, product_rating_params) do
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
