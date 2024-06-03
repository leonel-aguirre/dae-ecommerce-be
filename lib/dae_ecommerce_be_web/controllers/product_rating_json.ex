defmodule DaeEcommerceBeWeb.ProductRatingJSON do
  alias DaeEcommerceBe.ProductRatings.ProductRating

  @doc """
  Renders a list of product_ratings.
  """
  def index(%{product_ratings: product_ratings}) do
    %{data: for(product_rating <- product_ratings, do: data(product_rating))}
  end

  @doc """
  Renders a single product_rating.
  """
  def show(%{product_rating: product_rating}) do
    %{data: data(product_rating)}
  end

  defp data(%ProductRating{} = product_rating) do
    %{
      id: product_rating.id,
      rating: product_rating.rating,
      product_id: product_rating.product_id
    }
  end
end
