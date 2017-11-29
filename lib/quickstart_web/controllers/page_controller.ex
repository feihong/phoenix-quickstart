defmodule QuickstartWeb.PageController do
  use QuickstartWeb, :controller

  def index(conn, _params) do
    render conn, "index.html",
      heartbeat_active: Quickstart.HeartBeatServer.get_active()
  end

  def hanzi(conn, _params) do
    render conn, "hanzi.html"
  end

  def faces(conn, _params) do
    render conn, "faces.html"
  end
end
