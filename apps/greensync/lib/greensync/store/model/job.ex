defmodule Greensync.Store.Model.Job do
  use Ecto.Schema

  alias Greenhousex.Harvest.Job
  alias Greensync.Store.Model.DateTime

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
      opened_at: DateTime.normalize(job.opened_at),
      created_at: DateTime.normalize(job.created_at),
      updated_at: DateTime.normalize(job.updated_at),
      closed_at: DateTime.normalize(job.closed_at)
    }
  end
end
