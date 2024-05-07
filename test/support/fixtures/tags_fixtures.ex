defmodule DaeEcommerceBe.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaeEcommerceBe.Tags` context.
  """

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> DaeEcommerceBe.Tags.create_tag()

    tag
  end
end
