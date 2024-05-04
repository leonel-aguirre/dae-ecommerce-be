defmodule DaeEcommerceBe.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :title, :string
    field :is_disabled, :boolean, default: false
    field :current_price, :float
    field :previous_price, :float
    field :tags, {:array, :string}

    # Establishes a relationship between Product and User.
    belongs_to :user, DaeEcommerceBe.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :is_disabled, :current_price, :previous_price, :tags])
    |> validate_required([
      :title,
      :description,
      :current_price
    ])
  end
end
