defmodule DaeEcommerceBe.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        full_name: "some full_name"
      })
      |> DaeEcommerceBe.Users.create_user()

    user
  end
end
