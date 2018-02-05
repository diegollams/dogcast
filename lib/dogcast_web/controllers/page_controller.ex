defmodule DogcastWeb.PageController do
  use DogcastWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
