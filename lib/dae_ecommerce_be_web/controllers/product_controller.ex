defmodule DaeEcommerceBeWeb.ProductController do
  use DaeEcommerceBeWeb, :controller

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
