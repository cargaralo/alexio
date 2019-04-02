defmodule AlexioWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  # def join("room:" <> _private_room_id, _params, _socket) do
  #   {:error, %{reason: "unauthorized"}}
  # end

  def handle_in("new_player", %{"player_name" => player_name}, socket) do
    case GenServer.call(Alexio.Beat, {:new_player, player_name}) do
      :ok -> {:reply, :ok, socket}
      :error -> {:reply, :error, socket}
    end
  end

  def handle_in("move_player", %{"player_name" => player_name, "direction" => direction}, socket) do
    case GenServer.call(Alexio.Beat, {:move_player, player_name, direction}) do
      :ok -> {:reply, :ok, socket}
      :error -> {:reply, :error, socket}
    end
  end
end
