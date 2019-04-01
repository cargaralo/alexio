defmodule AlexioWeb.PageController do
  use AlexioWeb, :controller

  def index(conn, _params) do
    GenServer.cast(Alexio.Beat, :beat)
    render(conn, "index.html")
  end
end
