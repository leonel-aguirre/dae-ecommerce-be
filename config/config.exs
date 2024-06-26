# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :dae_ecommerce_be,
  ecto_repos: [DaeEcommerceBe.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :dae_ecommerce_be, DaeEcommerceBeWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: DaeEcommerceBeWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: DaeEcommerceBe.PubSub,
  live_view: [signing_salt: "prVb5hAM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian configuration.
config :dae_ecommerce_be, DaeEcommerceBeWeb.Auth.Guardian,
  issuer: "dae_ecommerce_be",
  secret_key: "WMXHp+FCDYSA1IMBuh0sP4VMv1COW70/aS6gg1kctFTJlkaPILSWXqTSOZRzovIo"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# GuardianDB config.
config :guardian, Guardian.DB,
  repo: DaeEcommerceBe.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
