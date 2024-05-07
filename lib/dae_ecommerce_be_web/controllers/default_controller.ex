defmodule DaeEcommerceBeWeb.DefaultController do
  use DaeEcommerceBeWeb, :controller

  def index(conn, params) do
    json(conn, %{message: "DAE Ecommerce API live - #{Mix.env()}"})
  end
end
