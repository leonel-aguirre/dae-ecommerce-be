defmodule DaeEcommerceBeWeb.DefaultController do
  use DaeEcommerceBeWeb, :controller

  def index(conn, _params) do
    text(conn, "DAE Ecommerce API live - #{Mix.env()}")
  end
end
