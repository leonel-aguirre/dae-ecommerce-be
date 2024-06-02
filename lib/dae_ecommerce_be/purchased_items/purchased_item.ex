defmodule DaeEcommerceBe.PurchasedItems.PurchasedItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "purchased_items" do
    # Establishes a relationship between PurchasedItem and User.
    belongs_to :user, DaeEcommerceBe.Users.User

    # Establishes a relationship between PurchasedItem and User.
    belongs_to :product, DaeEcommerceBe.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(purchased_item, attrs) do
    purchased_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
