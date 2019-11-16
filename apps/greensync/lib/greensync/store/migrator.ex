defmodule Greensync.Store.Migrator do
  require Logger

  def migrate do
    Logger.info("Running migrations")

    path = Application.app_dir(:greensync, "priv/repo/migrations")

    Ecto.Migrator.run(Greensync.Store.Repo, path, :up, all: true)
  end
end
