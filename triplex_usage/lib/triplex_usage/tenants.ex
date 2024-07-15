defmodule TriplexUsage.Tenants do
  alias Ecto.Multi
  alias TriplexUsage.Tenant
  alias TriplexUsage.User
  alias TriplexUsage.Repo

  @tenant_id_key :tenant_id

  def set_schema(schema) do
    Process.put(@tenant_id_key, schema)
  end

  def get_schema do
    Process.get(@tenant_id_key) || "public"
  end

  @doc """
  Steps:
  1. Create prefix/schema for given user,
  2. Write the result into `tenants` table,
  3. Create user and associate it with the tenant
  """
  def create_user do
    generate_schema()
    |> Triplex.create_schema(Repo, fn schema, repo ->
      {:ok, _result} = Triplex.migrate(schema, repo)

      Multi.new()
      |> Multi.run(:create_tenant, create_tenant(schema))
      |> Multi.run(:create_user, create_user(schema))
      |> Repo.transaction()
    end)
  end

  defp generate_schema, do: Ecto.UUID.generate()

  defp create_tenant(schema) do
    fn _repo, _attrs ->
      set_schema("public")

      %Tenant{}
      |> Tenant.changeset(%{uuid: schema})
      |> Repo.insert()
    end
  end

  defp create_user(schema) do
    fn _repo, %{create_tenant: %Tenant{id: tenant_id}} ->
      set_schema(schema)

      %User{}
      |> User.changeset(%{name: "test user", email: "test email", tenant_id: tenant_id})
      |> Repo.insert()
    end
  end
end
