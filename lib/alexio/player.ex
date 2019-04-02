defmodule Alexio.Player do
  @derive {Jason.Encoder, only: [:name, :x_position, :y_position, :x_movement, :y_movement, :fighting]}
  defstruct [:name, :x_position, :y_position, :x_movement, :y_movement, :fighting]

  def init(name, x_position, y_position) do
    %__MODULE__{name: name, x_position: x_position, y_position: y_position, fighting: false}
  end

  def move(player) do
    if player.x_movement != nil && player.y_movement != nil do
      %{player | x_position: player.x_movement, y_position: player.y_movement}
    else
      player
    end
  end
end
