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
      {generated_x, generated_y} = empty_position(plateau)
      new_player = Alexio.Player.init(player_name, generated_x, generated_y)

      players = Map.put(plateau.players, new_player.name, new_player)
      positions = Map.put(plateau.positions, {generated_x, generated_y}, player_name)

      {:ok, %__MODULE__{plateau | players: players, positions: positions}}
    end
  end

  def player_name_owned?(plateau = %__MODULE__{}, player_name) do
    Map.has_key?(plateau.players, player_name)
  end

  defp empty_position(plateau = %__MODULE__{}) do
    random_position = {Enum.random(0..plateau.x_size - 1), Enum.random(0..plateau.y_size - 1)}

    if Map.has_key?(plateau.positions, random_position) do
      empty_position(plateau)
    else
      random_position
    end
  end
end
