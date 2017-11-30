defmodule QuickstartWeb.PageController do
  use QuickstartWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def hanzi(conn, _params) do
    render conn, "hanzi.html",
      title: "Random Hanzi",
      body_id: "hanzi",
      layout: {QuickstartWeb.LayoutView, "layout2.html"}
  end

  def faces(conn, _params) do
    render conn, "faces.html",
      title: "Fun Faces",
      body_id: "faces",
      layout: {QuickstartWeb.LayoutView, "layout2.html"}
  end
end
