defmodule ForeignKeys.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :title, :string
    belongs_to :user, ForeignKeys.User
    has_many :links, ForeignKeys.Link

    timestamps()
  end

  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
