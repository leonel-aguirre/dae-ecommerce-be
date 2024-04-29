defmodule DaeEcommerceBeWeb.Router do
  use DaeEcommerceBeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DaeEcommerceBeWeb do
    pipe_through :api
  end
end
