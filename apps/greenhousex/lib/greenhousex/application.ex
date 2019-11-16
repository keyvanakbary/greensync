defmodule Greenhousex.Application do
  use Application

  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: Greenhousex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
