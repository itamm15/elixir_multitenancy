defmodule TriplexUsage.Repo.Migrations.TenantsTable do
  use Ecto.Migration

  def change do
    create table(:tenants) do
      add :uuid, :string

      timestamps()
    end
  end
end
