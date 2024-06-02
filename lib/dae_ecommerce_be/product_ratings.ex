defmodule DaeEcommerceBe.ProductRatings do
  @moduledoc """
  The ProductRatings context.
  """

  import Ecto.Query, warn: false
  alias DaeEcommerceBe.Repo

  alias DaeEcommerceBe.ProductRatings.ProductRating

  @doc """
  Returns the list of product_ratings.

  ## Examples

      iex> list_product_ratings()
      [%ProductRating{}, ...]

  """
  def list_product_ratings do
    Repo.all(ProductRating)
  end

  @doc """
  Gets a single product_rating.

  Raises `Ecto.NoResultsError` if the Product rating does not exist.

  ## Examples

      iex> get_product_rating!(123)
      %ProductRating{}

      iex> get_product_rating!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_rating!(id), do: Repo.get!(ProductRating, id)

  @doc """
  Creates a product_rating.

  ## Examples

      iex> create_product_rating(%{field: value})
      {:ok, %ProductRating{}}

      iex> create_product_rating(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_rating(attrs \\ %{}) do
    %ProductRating{}
    |> ProductRating.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_rating.

  ## Examples

      iex> update_product_rating(product_rating, %{field: new_value})
      {:ok, %ProductRating{}}

      iex> update_product_rating(product_rating, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_rating(%ProductRating{} = product_rating, attrs) do
    product_rating
    |> ProductRating.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_rating.

  ## Examples

      iex> delete_product_rating(product_rating)
      {:ok, %ProductRating{}}

      iex> delete_product_rating(product_rating)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_rating(%ProductRating{} = product_rating) do
    Repo.delete(product_rating)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_rating changes.

  ## Examples

      iex> change_product_rating(product_rating)
      %Ecto.Changeset{data: %ProductRating{}}

  """
  def change_product_rating(%ProductRating{} = product_rating, attrs \\ %{}) do
    ProductRating.changeset(product_rating, attrs)
  end
end
