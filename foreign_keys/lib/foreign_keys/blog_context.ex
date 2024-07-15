defmodule ForeignKeys.BlogContext do
  import Ecto.Query, warn: false
  alias ForeignKeys.Repo
  alias ForeignKeys.Blog

  def list_user_blogs(user_id) do
    Repo.all(from b in Blog, where: b.user_id == ^user_id)
  end

  def create_blog(user_id, attrs \\ %{}) do
    %Blog{}
    |> Blog.changeset(Map.put(attrs, :user_id, user_id))
    |> Repo.insert()
  end
end
