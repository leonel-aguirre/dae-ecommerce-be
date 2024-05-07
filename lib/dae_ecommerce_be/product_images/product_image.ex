defmodule DaeEcommerceBe.ProductImages.ProductImage do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "product_images" do
    field :data, :binary

    # Establishes a relationship between ProductImage and Product.
    belongs_to :product, DaeEcommerceBe.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_image, attrs) do
    product_image
    |> cast(attrs, [:data])
    |> validate_required([:data])
  end
end
