defmodule DaeEcommerceBe.CartItems.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cart_items" do
    # Establishes a relationship between CartItem and User.
    belongs_to :user, DaeEcommerceBe.Users.User

    # Establishes a relationship between Product and User.
    belongs_to :product, DaeEcommerceBe.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
