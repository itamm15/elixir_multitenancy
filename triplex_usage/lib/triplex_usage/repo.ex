defmodule TriplexUsage.Repo do
  use Ecto.Repo,
    otp_app: :triplex_usage,
    adapter: Ecto.Adapters.Postgres

  @impl true
  def default_options(_operation) do
    [prefix: Triplex.to_prefix(TriplexUsage.Tenants.get_schema())]
  end
end
