defmodule ForeignKeys.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
