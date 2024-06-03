defmodule DaeEcommerceBeWeb.ProductController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.ProductRatings
  alias DaeEcommerceBeWeb.Auth.ErrorResponse
  alias DaeEcommerceBe.Products
  alias DaeEcommerceBe.Products.Product

  action_fallback DaeEcommerceBeWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_available_products()

    render(conn, :index, products: products)
  end

  def index_by_user(conn, _params) do
    user_id = conn.assigns.account.user.id

    products = Products.list_products_by_user(user_id)

    render(conn, :index, products: products)
  end

  def featured(conn, _params) do
    product_ids = ProductRatings.list_products_with_ratings()

    if(length(product_ids) == 0) do
      conn
      |> put_status(200)
      |> json(%{})
    end

    product_total_ratings =
      Enum.map(product_ids, fn product_id ->
        ProductRatings.get_product_ratings_sum(product_id) /
          ProductRatings.get_product_ratings_amount(product_id)
      end)

    featured_product_index =
      product_total_ratings
      |> Enum.with_index()
      |> Enum.reduce({nil, -1}, fn {value, index}, {max_value, max_index} ->
        if max_value == nil or value > max_value do
          {value, index}
        else
          {max_value, max_index}
        end
      end)
      |> elem(1)

    featured_product =
      Products.get_product_with_images(Enum.at(product_ids, featured_product_index))

    conn
    |> put_status(200)
    |> render(:show_with_images, product: featured_product)
  end

  def search(conn, %{"term" => term, "tag" => tag}) do
    IO.inspect(term)
    IO.inspect(tag)

    products = Products.list_matching_products(term, tag)

    render(conn, :index, products: products)
  end

  def create(conn, %{"product" => product_params}) do
    user = conn.assigns.account.user

    with {:ok, %Product{} = product} <- Products.create_product(user, product_params) do
      conn
      |> put_status(:created)
      |> render(:show, product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    render(conn, :show, product: product)
  end

  def show_product_with_images(conn, %{"id" => id}) do
    product = Products.get_product_with_images(id)

    render(conn, :show_with_images, product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    user_id = conn.assigns.account.user.id
    product = Products.get_product!(id)

    if user_id === product.user_id do
      with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
        render(conn, :show, product: product)
      end
    else
      raise ErrorResponse.Unauthorized, message: "Unable to update this product."
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.account.user.id
    product = Products.get_product!(id)

    if user_id === product.user_id do
      with {:ok, %Product{}} <- Products.delete_product(product) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          200,
          Jason.encode!(%{message: "Product with id #{id} deleted successfully."})
        )
      end
    else
      raise ErrorResponse.Unauthorized, message: "Unable to delete this product."
    end
  end
end
