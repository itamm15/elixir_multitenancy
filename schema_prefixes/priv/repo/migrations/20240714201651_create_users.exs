defmodule SchemaPrefixes.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    Enum.each(["team_a", "team_b"], fn prefix ->
      create table(:users, prefix: prefix) do
        add :name, :string
        add :email, :string

        timestamps()
      end
    end)
  end
end
