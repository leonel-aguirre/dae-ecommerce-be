defmodule DaeEcommerceBeWeb.UserJSON do
  alias DaeEcommerceBe.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def data(%User{} = user) do
    %{
      id: user.id,
      full_name: user.full_name
    }
  end
end
