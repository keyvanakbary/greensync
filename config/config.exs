use Mix.Config

config :greensync, ecto_repos: [Greensync.Store.Repo]

config :greensync, Greensync.Store.Repo,
  database: System.get_env("DB_NAME", "greensync"),
  username: System.get_env("DB_USER", "greensync"),
  password: System.get_env("DB_PASS", "pass"),
  hostname: System.get_env("DB_HOST", "127.0.0.1"),
  port: System.get_env("DB_PORT", "3306") |> String.to_integer()

config :greensync, greenhouse_api_token: System.get_env("GREENHOUSE_API_TOKEN", "")

config :greensync, Greensync.Scheduler,
  overlap: false,
  jobs: [
    {"*/15 * * * *", {Greensync.Sync, :all, []}}
  ]

config :logger, level: :info
