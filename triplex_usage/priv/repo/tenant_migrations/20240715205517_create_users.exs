defmodule TriplexUsage.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string

      add :tenant_id, references(:tenants, prefix: "public")

      timestamps()
    end
  end
end
