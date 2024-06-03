defmodule DaeEcommerceBe.ProductRatings.ProductRating do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "product_ratings" do
    field :rating, :float

    # Establishes a relationship between ProductRating and User.
    belongs_to :user, DaeEcommerceBe.Users.User

    # Establishes a relationship between ProductRating and User.
    belongs_to :product, DaeEcommerceBe.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_rating, attrs) do
    product_rating
    |> cast(attrs, [:rating])
    |> validate_required([:rating])
  end
end
