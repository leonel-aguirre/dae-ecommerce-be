defmodule DaeEcommerceBeWeb.ProductImageController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.Products
  alias DaeEcommerceBe.ProductImages
  alias DaeEcommerceBe.ProductImages.ProductImage

  action_fallback DaeEcommerceBeWeb.FallbackController

  def upload(conn, %{"data" => data, "product_id" => product_id}) do
    user_id = conn.assigns.account.user.id
    product = Products.get_product!(product_id)

    if user_id === product.user_id do
      binaryFile = File.read!(data.path)

      with {:ok, %ProductImage{} = _product_image} <-
             ProductImages.create_product_image(product, %{data: binaryFile}) do
        conn
        |> put_status(:created)
        |> json(%{message: "success"})
      end
    end
  end

  def index(conn, _params) do
    product_images = ProductImages.list_product_images()
    render(conn, :index, product_images: product_images)
  end

  def create(conn, %{"product_image" => product_image_params}) do
    with {:ok, %ProductImage{} = product_image} <-
           ProductImages.create_product_image(product_image_params) do
      conn
      |> put_status(:created)
      |> render(:show, product_image: product_image)
    end
  end

  def show(conn, %{"image_id" => image_id}) do
    product_image = ProductImages.get_product_image!(image_id)

    conn
    |> put_resp_content_type("image/png")
    |> send_resp(200, product_image.data)
  end

  def update(conn, %{"id" => id, "product_image" => product_image_params}) do
    product_image = ProductImages.get_product_image!(id)

    with {:ok, %ProductImage{} = product_image} <-
           ProductImages.update_product_image(product_image, product_image_params) do
      render(conn, :show, product_image: product_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_image = ProductImages.get_product_image!(id)

    with {:ok, %ProductImage{}} <- ProductImages.delete_product_image(product_image) do
      send_resp(conn, :no_content, "")
    end
  end
end
