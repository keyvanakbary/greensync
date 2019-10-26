defmodule Greensync.Store.Model.Job do
  use Ecto.Schema

  alias Greenhousex.Harvest.Job

  schema "jobs" do
    field(:name)
    field(:confidential, :boolean)
    field(:status)
    field(:opened_at, :utc_datetime)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:closed_at, :utc_datetime)
  end

  def from_harvest(%Job{} = job) do
    %__MODULE__{
      id: job.id,
      name: job.name,
      confidential: job.confidential,
      status: job.status,
      opened_at: job.opened_at,
      created_at: job.created_at,
      updated_at: job.updated_at,
      closed_at: job.closed_at
    }
  end
end
