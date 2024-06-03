defmodule DaeEcommerceBeWeb.AccountController do
  use DaeEcommerceBeWeb, :controller

  alias DaeEcommerceBeWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias DaeEcommerceBe.{Accounts, Users, Accounts.Account, Users.User}

  import DaeEcommerceBeWeb.Auth.AuthorizedPlug

  plug :is_authorized when action in [:update, :delete]

  action_fallback DaeEcommerceBeWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["password"])
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    authorize_account(conn, email, password)
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_resp_cookie("auth_token", token, http_only: true)
        |> put_status(:ok)
        |> render(:account_token, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def refresh_session(conn, %{}) do
    token = Guardian.Plug.current_token(conn)

    {:ok, account, new_token} = Guardian.authenticate(token)

    conn
    |> Plug.Conn.put_session(:account_id, account.id)
    |> put_status(:ok)
    |> render(:account_token, %{account: account, token: new_token})
  end

  def sign_out(conn, %{}) do
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> put_resp_cookie("auth_token", "", http_only: true, max_age: 0)
    |> render(:account_token, %{account: account, token: nil})
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_full_account(id)
    render(conn, :full_account, account: account)
  end

  def current_account(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render(:full_account, %{account: conn.assigns.account})
  end

  def update(conn, %{"current_password" => current_password, "account" => account_params}) do
    case Guardian.validate_password(current_password, conn.assigns.account.password) do
      true ->
        {:ok, account} = Accounts.update_account(conn.assigns.account, account_params)
        render(conn, :show, account: account)

      false ->
        raise ErrorResponse.Unauthorized, message: "Password incorrect."
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
