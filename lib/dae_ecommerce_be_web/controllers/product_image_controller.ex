defmodule DaeEcommerceBeWeb.ProductImageController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBe.ProductImages
  alias DaeEcommerceBe.ProductImages.ProductImage

  action_fallback DaeEcommerceBeWeb.FallbackController

  def test(conn, params) do
    IO.inspect(params)

    binaryFile = File.read!(params["data"].path)

    # conn
    # |> put_status(:created)
    # |> json(%{message: "success"})

    # ProductImages.create_product_image(params)

    with {:ok, %ProductImage{} = _product_image} <-
           ProductImages.create_product_image(%{data: binaryFile}) do
      conn
      |> put_status(:created)
      |> json(%{message: "success"})

      # |> render(:show, product_image: product_image)
      # else
      #   conn
      #   |> json(%{message: "error"})
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
      |> put_resp_header("location", ~p"/api/product_images/#{product_image}")
      |> render(:show, product_image: product_image)
    end
  end

  def show(conn, %{"id" => id}) do
    product_image = ProductImages.get_product_image!(id)
    render(conn, :show, product_image: product_image)
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
