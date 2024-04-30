defmodule DaeEcommerceBeWeb.Router do
  use DaeEcommerceBeWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Ensures authentication before triggering the service.
  pipeline :auth do
    plug DaeEcommerceBeWeb.Auth.Pipeline
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
    get "/accounts/by_id/:id", AccountController, :show
  end
end
