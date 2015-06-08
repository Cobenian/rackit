use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rackit, Rackit.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :rackit, Rackit.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "rackit",
  password: "I am a developer and I am here to help.",
  database: "rackit_test",
  size: 1 # Use a single connection for transactional tests
