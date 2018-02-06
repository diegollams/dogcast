defmodule Dogcast.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dogcast.Comment


  schema "comments" do
    field :content, :string
    belongs_to :post, Dogcast.Post, foreign_key: :post_id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id])
    |> validate_required([:content, :post_id])
  end
end
