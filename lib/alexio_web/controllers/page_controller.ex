defmodule AlexioWeb.PageController do
  use AlexioWeb, :controller

  def index(conn, %{"player_name" => player_name}) do
    GenServer.cast(Alexio.Beat, {:new_player, player_name})
    render(conn, "index.html")
  end
end
