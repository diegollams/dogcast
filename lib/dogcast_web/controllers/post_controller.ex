defmodule DogcastWeb.PostController do
  use DogcastWeb, :controller

  alias Dogcast.DogcastWeb
  alias Dogcast.Post
  alias Dogcast.Comment
  alias Dogcast.Repo

  plug :scrub_params, "comment" when action in [:add_comment]

  def index(conn, _params) do
    posts = DogcastWeb.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = DogcastWeb.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case DogcastWeb.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post      = Repo.get(Post, id) |> Repo.preload([:comments])
    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "show.html", post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post      = DogcastWeb.get_post!(id)
    changeset = DogcastWeb.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = DogcastWeb.get_post!(id)

    case DogcastWeb.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def add_comment(conn,  %{"comment" => comment_params, "post_id" => post_id}) do
    changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "post_id", post_id))
    post      = Post |> Repo.get(post_id) |> Repo.preload([:comments])
    if changeset.valid? do
      Repo.insert(changeset)
      conn
      |> put_flash(:info, "Comment added.")
      |> redirect(to: post_path(conn, :show, post))
    else
      conn
      |> put_flash(:info, "Comment not added.")
      |> render(conn, "show.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = DogcastWeb.get_post!(id)
    {:ok, _post} = DogcastWeb.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
