defmodule Dogcast.DogcastWebTest do
  use Dogcast.DataCase

  alias Dogcast.DogcastWeb

  describe "posts" do
    alias Dogcast.DogcastWeb.Post

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DogcastWeb.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert DogcastWeb.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert DogcastWeb.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = DogcastWeb.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DogcastWeb.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = DogcastWeb.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.body == "some updated body"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = DogcastWeb.update_post(post, @invalid_attrs)
      assert post == DogcastWeb.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = DogcastWeb.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> DogcastWeb.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = DogcastWeb.change_post(post)
    end
  end
end
