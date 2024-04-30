defmodule DaeEcommerceBeWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule DaeEcommerceBeWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "You do not have access to this resource.", plug_status: 403
end
