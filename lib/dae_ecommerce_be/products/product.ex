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

    # Establishes a relationship between Product and ProductImage.
    has_many :product_images, DaeEcommerceBe.ProductImages.ProductImage, on_delete: :delete_all

    # Establishes a relationship between Product and CartItem.
    has_many :cart_items, DaeEcommerceBe.CartItems.CartItem, on_delete: :delete_all

    # Establishes a relationship between Product and PurchasedItem.
    has_many :purchased_items, DaeEcommerceBe.PurchasedItems.PurchasedItem, on_delete: :delete_all

    # Establishes a relationship between Product and ProductRatings.
    has_many :product_ratings, DaeEcommerceBe.ProductRatings.ProductRating, on_delete: :delete_all

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
