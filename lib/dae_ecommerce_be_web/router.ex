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
    get "/products", ProductController, :index
  end
end
