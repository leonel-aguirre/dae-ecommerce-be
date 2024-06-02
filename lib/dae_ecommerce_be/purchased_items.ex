defmodule DaeEcommerceBe.PurchasedItems do
  @moduledoc """
  The PurchasedItems context.
  """

  import Ecto.Query, warn: false
  alias DaeEcommerceBe.Repo

  alias DaeEcommerceBe.PurchasedItems.PurchasedItem

  @doc """
  Returns the list of purchased_items.

  ## Examples

      iex> list_purchased_items()
      [%PurchasedItem{}, ...]

  """
  def list_purchased_items do
    Repo.all(PurchasedItem)
  end

  @doc """
  Gets a single purchased_item.

  Raises `Ecto.NoResultsError` if the Purchased item does not exist.

  ## Examples

      iex> get_purchased_item!(123)
      %PurchasedItem{}

      iex> get_purchased_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_purchased_item!(id), do: Repo.get!(PurchasedItem, id)

  @doc """
  Creates a purchased_item.

  ## Examples

      iex> create_purchased_item(%{field: value})
      {:ok, %PurchasedItem{}}

      iex> create_purchased_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_purchased_item(attrs \\ %{}) do
    %PurchasedItem{}
    |> PurchasedItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a purchased_item.

  ## Examples

      iex> update_purchased_item(purchased_item, %{field: new_value})
      {:ok, %PurchasedItem{}}

      iex> update_purchased_item(purchased_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_purchased_item(%PurchasedItem{} = purchased_item, attrs) do
    purchased_item
    |> PurchasedItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a purchased_item.

  ## Examples

      iex> delete_purchased_item(purchased_item)
      {:ok, %PurchasedItem{}}

      iex> delete_purchased_item(purchased_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_purchased_item(%PurchasedItem{} = purchased_item) do
    Repo.delete(purchased_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchased_item changes.

  ## Examples

      iex> change_purchased_item(purchased_item)
      %Ecto.Changeset{data: %PurchasedItem{}}

  """
  def change_purchased_item(%PurchasedItem{} = purchased_item, attrs \\ %{}) do
    PurchasedItem.changeset(purchased_item, attrs)
  end
end
