defmodule SchemaPrefixes.Repo do
  use Ecto.Repo,
    otp_app: :schema_prefixes,
    adapter: Ecto.Adapters.Postgres


  @impl true
  def default_options(_options) do
    tenat = get_tenant()
    if tenat, do: [prefix: get_tenant()]
  end

  @tenant_key :tenant

  def set_tenant(tenant) do
    Process.put(@tenant_key, tenant)
  end

  def get_tenant()  do
    Process.get(@tenant_key)
  end
end
