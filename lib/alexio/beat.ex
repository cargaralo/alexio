defmodule Alexio.Beat do
  use GenServer

  def init(_state) do
    reschedule()
    {:ok, %{plateau: []}}
  end

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def handle_info(:beat, state) do
    AlexioWeb.Endpoint.broadcast!("room:lobby", "new_msg", state)
    reschedule()
    {:noreply, state}
  end

  def handle_cast({:new_player, player_name}, state) do
    {:noreply, %{plateau: [player_name | state.plateau]}}
  end

  defp reschedule do
    Process.send_after(self(), :beat, 1_000)
  end
end
