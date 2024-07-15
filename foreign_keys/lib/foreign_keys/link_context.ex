defmodule ForeignKeys.LinkContext do
  import Ecto.Query, warn: false
  alias ForeignKeys.Repo
  alias ForeignKeys.Link

  def list_blog_links_by_blog_id(blog_id) do
    Repo.all(from l in Link, where: l.blog_id == ^blog_id)
  end

  def list_blog_links_by_user_id(user_id) do
    Repo.all(from l in Link, where: l.user_id == ^user_id)
  end

  def create_link(user_id, blog_id, attrs \\ %{}) do
    %Link{}
    |> Link.changeset(Map.merge(attrs, %{user_id: user_id, blog_id: blog_id}))
    |> Repo.insert()
  end
end
