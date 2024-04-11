defmodule DaeEcommerceBe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DaeEcommerceBeWeb.Telemetry,
      DaeEcommerceBe.Repo,
      {DNSCluster, query: Application.get_env(:dae_ecommerce_be, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DaeEcommerceBe.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DaeEcommerceBe.Finch},
      # Start a worker by calling: DaeEcommerceBe.Worker.start_link(arg)
      # {DaeEcommerceBe.Worker, arg},
      # Start to serve requests, typically the last entry
      DaeEcommerceBeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DaeEcommerceBe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DaeEcommerceBeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
