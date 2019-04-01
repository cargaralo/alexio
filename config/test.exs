use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :alexio, AlexioWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :alexio, Alexio.Repo,
  username: "postgres",
  password: "postgres",
  database: "alexio_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
