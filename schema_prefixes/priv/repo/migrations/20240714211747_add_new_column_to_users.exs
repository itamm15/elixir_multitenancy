defmodule SchemaPrefixes.Repo.Migrations.AddNewColumnToUsers do
  use Ecto.Migration

  def change do
    Enum.each(["team_a", "team_b"], fn prefix ->
      alter table(:users, prefix: prefix) do
        add :password, :string
      end
    end)
  end
end
