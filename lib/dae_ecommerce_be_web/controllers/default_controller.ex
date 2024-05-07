defmodule DaeEcommerceBeWeb.DefaultController do
  use DaeEcommerceBeWeb, :controller

  def index(conn) do
    json(conn, %{message: "DAE Ecommerce API live - #{Mix.env()}"})
  end
end
