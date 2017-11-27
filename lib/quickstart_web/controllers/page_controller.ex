defmodule QuickstartWeb.PageController do
  use QuickstartWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
