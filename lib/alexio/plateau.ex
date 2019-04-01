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
      new_player = Alexio.Player.init(player_name, 0, 0)

      players = Map.put(plateau.players, new_player.name, new_player)
      positions = Map.put(plateau.positions, {new_player.x_position, new_player.y_position}, player_name)

      {:ok, %__MODULE__{plateau | players: players, positions: positions}}
    end
  end

  def player_name_owned?(plateau = %__MODULE__{}, player_name) do
    Map.has_key?(plateau.players, player_name)
  end
end
