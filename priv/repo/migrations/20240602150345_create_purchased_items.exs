defmodule DaeEcommerceBe.Repo.Migrations.CreatePurchasedItems do
  use Ecto.Migration

  def change do
    create table(:purchased_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:purchased_items, [:product_id])
    create index(:purchased_items, [:user_id])
  end
end
