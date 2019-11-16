defmodule Mix.Tasks.Sync.All do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    Greensync.Sync.all()
  end
end
