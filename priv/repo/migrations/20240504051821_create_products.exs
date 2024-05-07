defmodule DaeEcommerceBe.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :is_disabled, :boolean, default: false, null: false
      add :current_price, :float
      add :previous_price, :float
      add :tags, {:array, :string}
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:user_id, :title, :tags])
  end
end
