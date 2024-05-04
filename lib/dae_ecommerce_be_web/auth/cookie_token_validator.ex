defmodule DaeEcommerceBeWeb.Auth.CookieTokenValidator do
  import Plug.Conn
  alias Guardian.Plug.Pipeline

  @behaviour Plug
  @impl Plug
  def init(opts), do: opts
  @impl Plug
  def call(conn, opts) do
    with {:ok, token} <- get_token_from_cookie(conn, opts),
         module <- Pipeline.fetch_module!(conn, opts),
         {:ok, claims} <- Guardian.decode_and_verify(module, token, %{}, opts) do
      conn
      |> Guardian.Plug.put_current_token(token, key: "default")
      |> Guardian.Plug.put_current_claims(claims, key: "default")
    else
      _error ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!(%{error: to_string(:invalid_token)}))
        |> halt()
    end
  end

  defp get_token_from_cookie(conn, opts) do
    key = Keyword.get(opts, :key, "auth_token")
    token = conn.req_cookies[key]
    if token, do: {:ok, token}, else: :no_token_found
  end
end
