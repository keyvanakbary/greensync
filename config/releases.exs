import Config

config :greensync, Greensync.Store.Repo,
  database: System.fetch_env!("DB_NAME"),
  username: System.fetch_env!("DB_USER"),
  password: System.fetch_env!("DB_PASS"),
  hostname: System.fetch_env!("DB_HOST"),
  port: System.get_env("DB_PORT", "3306") |> String.to_integer()

config :greensync, :greenhouse_api_token, System.fetch_env!("GREENHOUSE_API_TOKEN")

config :greensync, Greensync.Scheduler, jobs: [
  {System.get_env("CRON_SCHEDULE", "*/15 * * * *"), {Greensync.Sync, :all, []}}
]
