defmodule Alexio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      # Alexio.Repo,
      # Start the endpoint when the application starts
      AlexioWeb.Endpoint,
      {Alexio.Beat, %{}}
      # supervisor(Alexio.Supervisor, [])
      # Starts a worker by calling: Alexio.Worker.start_link(arg)
      # {Alexio.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Alexio.Game]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AlexioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
