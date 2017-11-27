defmodule QuickstartWeb.PageController do
  use QuickstartWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def cool(conn, _params) do
    render conn, "cool.html"    
  end
end
