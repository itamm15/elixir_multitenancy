defmodule SchemaPrefixes.UserContext do
  import Ecto.Query

  alias SchemaPrefixes.Repo
  alias SchemaPrefixes.User

  def list_users() do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
