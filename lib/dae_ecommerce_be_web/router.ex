defmodule DaeEcommerceBeWeb.Router do
  use DaeEcommerceBeWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  # Ensures authentication before triggering the service.
  pipeline :auth do
    plug DaeEcommerceBeWeb.Auth.Pipeline
    plug DaeEcommerceBeWeb.Auth.SetAccount
  end

  scope "/api", DaeEcommerceBeWeb do
    pipe_through :api

    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in

    get "/featured/product", ProductController, :featured
    get "/product_categories", TagController, :index
    get "/products/image/:image_id", ProductImageController, :show
    get "/products", ProductController, :index
    post "/search", ProductController, :search

    get "/product/total_rating/:product_id", ProductRatingController, :product_total_rating
  end

  # Authentication required.
  scope "/api", DaeEcommerceBeWeb do
    pipe_through [:api, :auth]
    get "/accounts/current", AccountController, :current_account
    get "/accounts/sign_out", AccountController, :sign_out
    get "/accounts/refresh_session", AccountController, :refresh_session
    post "/accounts/update", AccountController, :update
    put "/users/update", UserController, :update

    post "/products", ProductController, :create
    get "/user/products", ProductController, :index_by_user
    get "/products/:id", ProductController, :show_product_with_images
    put "/products/:id", ProductController, :update
    delete "/products/:id", ProductController, :delete

    post "/products/upload_image/:product_id", ProductImageController, :upload

    post "/cart/add_item", CartItemController, :add_item
    get "/cart/items", CartItemController, :all_items
    get "/cart/items_amount", CartItemController, :item_amount
    delete "/cart/item/:cart_item_id", CartItemController, :delete

    post "/cart/purchase-items", PurchasedItemController, :purchase_items
    get "/cart/purchased-items", PurchasedItemController, :get_user_purchased_items

    post "/product/rating", ProductRatingController, :create
    get "/product/user_rating/:product_id", ProductRatingController, :user_rated_product
    get "/product/user_ratings", ProductRatingController, :user_rated_products
  end
end
