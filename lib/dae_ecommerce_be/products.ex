defmodule DaeEcommerceBe.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias DaeEcommerceBe.Repo

  alias DaeEcommerceBe.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_available_products do
    Product
    |> where(is_disabled: false)
    |> preload([:product_images])
    |> Repo.all()
  end

  def list_products_by_user(user_id) do
    Product
    |> where(user_id: ^user_id)
    |> preload([:product_images])
    |> Repo.all()
  end

  def get_featured_product() do
    Product
    |> where(id: ^"f77a75a1-66ac-45b4-9bae-7c17022d330e")
    |> preload([:product_images])
    |> Repo.one()
  end

  def list_matching_products(term, tag \\ nil) do
    Product
    |> where(is_disabled: false)
    |> maybe_filter_by_tag(tag)
    |> where([p], ilike(p.title, ^"%#{term}%") or ilike(p.description, ^"%#{term}%"))
    |> preload([:product_images])
    |> Repo.all()
  end

  defp maybe_filter_by_tag(query, nil), do: query

  defp maybe_filter_by_tag(query, tag) do
    query
    |> where([p], fragment("? @> ?", p.tags, ^[tag]))
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  def get_product_with_images(id) do
    Product
    |> where(id: ^id)
    |> preload([:product_images])
    |> Repo.one()
  end

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:products)
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  # def create_user(account, attrs \\ %{}) do
  #   account
  #   # Creates the association between the account id and the user.
  #   |> Ecto.build_assoc(:user)
  #   |> User.changeset(attrs)
  #   |> Repo.insert()
  # end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
