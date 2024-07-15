defmodule TriplexUsage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TriplexUsageWeb.Telemetry,
      TriplexUsage.Repo,
      {DNSCluster, query: Application.get_env(:triplex_usage, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TriplexUsage.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TriplexUsage.Finch},
      # Start a worker by calling: TriplexUsage.Worker.start_link(arg)
      # {TriplexUsage.Worker, arg},
      # Start to serve requests, typically the last entry
      TriplexUsageWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TriplexUsage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TriplexUsageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
