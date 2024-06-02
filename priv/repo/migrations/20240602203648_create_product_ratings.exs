defmodule DaeEcommerceBe.Repo.Migrations.CreateProductRatings do
  use Ecto.Migration

  def change do
    create table(:product_ratings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :rating, :float
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:product_ratings, [:user_id, :product_id], name: :user_product_id)
  end
end
