defmodule DaeEcommerceBe.Repo do
  use Ecto.Repo,
    otp_app: :dae_ecommerce_be,
    adapter: Ecto.Adapters.Postgres
end
