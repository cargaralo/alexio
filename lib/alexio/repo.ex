defmodule Alexio.Repo do
  use Ecto.Repo,
    otp_app: :alexio,
    adapter: Ecto.Adapters.Postgres
end
