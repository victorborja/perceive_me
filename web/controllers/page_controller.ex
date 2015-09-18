defmodule PerceiveMe.PageController do
  use PerceiveMe.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
