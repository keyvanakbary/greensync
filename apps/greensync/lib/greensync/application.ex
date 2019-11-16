defmodule Greensync.Application do
  use Application

  def start(_type, _args) do
    children = [
      Greensync.Store,
      Greensync.Scheduler
    ]

    opts = [strategy: :one_for_one, name: Greensync.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
