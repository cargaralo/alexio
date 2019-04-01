defmodule Alexio.Player do
  @derive {Jason.Encoder, only: [:name, :x_position, :y_position]}
  defstruct [:name, :x_position, :y_position]

  def init(name, x_position, y_position) do
    %__MODULE__{name: name, x_position: x_position, y_position: y_position}
  end
end
