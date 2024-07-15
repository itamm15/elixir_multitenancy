defmodule SchemaPrefixes.Repo.Migrations.CreateSamplePrefixes do
  use Ecto.Migration

  def change do
    execute "CREATE SCHEMA team_a"
    execute "CREATE SCHEMA team_b"
  end
end
