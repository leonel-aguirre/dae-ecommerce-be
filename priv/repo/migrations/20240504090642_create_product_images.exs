defmodule DaeEcommerceBe.Repo.Migrations.CreateProductImages do
  use Ecto.Migration

  def change do
    create table(:product_images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :data, :binary
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:product_images, [:product_id])
  end
end
