defmodule CardTokeniser.PageController do
  use CardTokeniser.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
