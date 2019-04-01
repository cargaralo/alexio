defmodule Alexio.Plateau do
  @derive {Jason.Encoder, only: [:x_size, :y_size, :players]}
  defstruct [:x_size, :y_size, :positions, :players]

  def init(x_size, y_size) do
    %__MODULE__{x_size: x_size, y_size: y_size, positions: %{}, players: %{}}
  end

  def add_player(plateau = %__MODULE__{}, player_name) do
    if player_name_owned?(plateau, player_name) do
      {:error, plateau}
    else
      players = Map.put(plateau.players, player_name, player_name)
      positions = Map.put(plateau.positions, {0, 0}, player_name)

      {:ok, %__MODULE__{plateau | players: players, positions: positions}}
    end
  end

  def player_name_owned?(plateau = %__MODULE__{}, player_name) do
    Map.has_key?(plateau.players, player_name)
  end
end
