defmodule DaeEcommerceBe.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :full_name, :string

    # Establishes a relationship between User and Account.
    belongs_to :account, DaeEcommerceBe.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :full_name])
    |> validate_required([:account_id, :full_name])
  end
end