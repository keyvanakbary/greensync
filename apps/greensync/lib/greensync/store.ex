defmodule Greensync.Store do
  @moduledoc """
  Repo wrapper to execute the migrations before starting the app
  """

  alias Greensync.Store.{Repo, Migrator}

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor
    }
  end

  def start_link(opts) do
    {:ok, pid} = Repo.start_link(opts)
    Migrator.migrate()
    {:ok, pid}
  end
end
