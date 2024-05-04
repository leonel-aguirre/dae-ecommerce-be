defmodule DaeEcommerceBeWeb.ProductController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.Products
  alias DaeEcommerceBe.Products.Product

  action_fallback DaeEcommerceBeWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
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
    product = Products.get_product!(id)

    with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
      render(conn, :show, product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    with {:ok, %Product{}} <- Products.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
