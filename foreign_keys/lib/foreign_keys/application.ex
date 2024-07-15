defmodule ForeignKeys.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ForeignKeysWeb.Telemetry,
      ForeignKeys.Repo,
      {DNSCluster, query: Application.get_env(:foreign_keys, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ForeignKeys.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ForeignKeys.Finch},
      # Start a worker by calling: ForeignKeys.Worker.start_link(arg)
      # {ForeignKeys.Worker, arg},
      # Start to serve requests, typically the last entry
      ForeignKeysWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ForeignKeys.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ForeignKeysWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
