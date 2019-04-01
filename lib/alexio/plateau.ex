defmodule Alexio.Plateau do
  @derive {Jason.Encoder, only: [:x_size, :y_size, :players]}
  defstruct [:x_size, :y_size, :positions, :players]

  def init(x_size, y_size) do
    %__MODULE__{x_size: x_size, y_size: y_size, positions: %{}, players: %{}}
  end

  def add_player(plateau = %__MODULE__{}, player_name) do
    players = Map.put(plateau.players, player_name, player_name)
    positions = Map.put(plateau.positions, {0, 0}, player_name)

    %__MODULE__{plateau | players: players, positions: positions}
  end
end
