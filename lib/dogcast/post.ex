defmodule Dogcast.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dogcast.Post


  schema "posts" do
    field :body, :string
    field :title, :string
    has_many :comments, Dogcast.Comment

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
