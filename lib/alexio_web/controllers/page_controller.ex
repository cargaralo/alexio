defmodule AlexioWeb.PageController do
  use AlexioWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def test(conn, %{"body" => body}) do
    AlexioWeb.Endpoint.broadcast!("room:lobby", "new_msg", %{body: body})
    json(conn,%{})
  end
end
