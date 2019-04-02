defmodule Alexio.Plateau do
  @derive {Jason.Encoder, only: [:x_size, :y_size, :players]}
  defstruct [:x_size, :y_size, :positions, :players]

  @movement %{
    "UP" => {0, 1},
    "RIGHT" => {1, 0},
    "DOWN" => {0, -1},
    "LEFT" => {-1, 0}
  }

  def init(x_size, y_size) do
    %__MODULE__{x_size: x_size, y_size: y_size, positions: %{}, players: %{}}
  end

  def add_player(plateau = %__MODULE__{}, player_name) do
    if player_name_owned?(plateau, player_name) do
      {:error, plateau}
    else
      {generated_x, generated_y} = random_position(plateau)
      new_player = Alexio.Player.init(player_name, generated_x, generated_y)

      players = Map.put(plateau.players, new_player.name, new_player)
      positions = Map.put(plateau.positions, {generated_x, generated_y}, [player_name])

      {:ok, %__MODULE__{plateau | players: players, positions: positions}}
    end
  end

  def move_player(plateau = %__MODULE__{}, player_name, direction) do
    player = plateau.players[player_name]

    {new_x_position, new_y_position} =
      calculate_movement(player.x_position, player.y_position, direction)

    player_moved = %{plateau.players[player_name] | x_movement: new_x_position, y_movement: new_y_position}
    players = Map.put(plateau.players, player_name, player_moved)

    {:ok, %__MODULE__{ plateau | players: players}}
  end

  def update_status(plateau = %__MODULE__{}) do
    plateau
    |> resolve_battles()
    |> move_all_players()
  end

  def player_name_owned?(plateau = %__MODULE__{}, player_name) do
    Map.has_key?(plateau.players, player_name)
  end

  defp resolve_battles(plateau = %__MODULE__{}) do
    plateau
  end

  defp move_all_players(plateau = %__MODULE__{}) do
    new_positions = %{}

    new_players = Enum.map(plateau.players, fn({player_name, player}) ->
      player_moved = Alexio.Player.move(player)

      if player_moved.x_position <= plateau.x_size && player_moved.x_position >= 0 && player_moved.y_position <= plateau.y_size && player_moved.y_position >= 0 do
        Map.put(new_positions, {player_moved.x_position, player_moved.y_position}, player_name)
        {player_name, player_moved}
      else
        {player_name, player}
      end
    end) |> Enum.into(%{})

    %__MODULE__{plateau | positions: new_positions, players: new_players}
  end

  defp calculate_movement(x_position, y_position, direction) do
    {x_direction, y_direction} = @movement[direction]

    {x_position + x_direction, y_position + y_direction}
  end

  defp random_position(plateau = %__MODULE__{}) do
    x_position = Enum.random(0..plateau.x_size - 1)
    y_position = Enum.random(0..plateau.y_size - 1)

    if !Map.has_key?(plateau.positions, {x_position, y_position}) do
      {x_position, y_position}
    else
      random_position(plateau)
    end
  end
end
