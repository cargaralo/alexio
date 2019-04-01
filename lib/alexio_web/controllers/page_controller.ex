defmodule AlexioWeb.PageController do
  use AlexioWeb, :controller

  def index(conn, %{"player_name" => player_name}) do
    case GenServer.call(Alexio.Beat, {:new_player, player_name}) do
      :ok -> render(conn, "index.html")
      :error -> json(conn, %{error: "User name alredy owned"})
    end
  end
end
