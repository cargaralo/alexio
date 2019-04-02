defmodule Alexio.Beat do
  use GenServer

  def init(_state) do
    reschedule()
    {:ok, Alexio.Plateau.init(10, 10)}
  end

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def handle_info(:beat, plateau) do
    updated_plateau = Alexio.Plateau.update_status(plateau)
    AlexioWeb.Endpoint.broadcast!("room:lobby", "beat", updated_plateau)

    reschedule()
    {:noreply, updated_plateau}
  end

  def handle_cast(:beat, plateau) do
    {:noreply, plateau}
  end

  def handle_call({:new_player, player_name}, _from, plateau) do
    {status, plateau} = Alexio.Plateau.add_player(plateau, player_name)

    {:reply, status, plateau}
  end

  def handle_call({:move_player, player_name, direction}, _from, plateau) do
    {status, plateau} = Alexio.Plateau.move_player(plateau, player_name, direction)

    {:reply, status, plateau}
  end

  defp reschedule do
    Process.send_after(self(), :beat, 1_000)
  end
end
