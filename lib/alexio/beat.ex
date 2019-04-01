defmodule Alexio.Beat do
  use GenServer

  def init(stack) do
    reschedule()
    {:ok, stack}
  end

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def handle_info(:work, state) do
    AlexioWeb.Endpoint.broadcast!("room:lobby", "new_msg", %{body: "1"})
    reschedule()
    {:noreply, state}
  end

  defp reschedule do
    Process.send_after(self(), :work, 1_000)
  end
end
