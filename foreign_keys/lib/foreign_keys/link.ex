defmodule ForeignKeys.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :url, :string
    belongs_to :blog, ForeignKeys.Blog
    belongs_to :user, ForeignKeys.User

    timestamps()
  end

  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :blog_id, :user_id])
    |> validate_required([:url, :blog_id, :user_id])
  end
end
