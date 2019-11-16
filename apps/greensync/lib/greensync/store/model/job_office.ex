defmodule Greensync.Store.Model.JobOffice do
  use Ecto.Schema

  alias Greenhousex.Harvest.Job

  @primary_key false
  schema "job_offices" do
    field(:job_id, :integer)
    field(:office_id, :integer)
  end

  def from_harvest(%Job{} = job) do
    Enum.map(job.office_ids, fn id ->
      %__MODULE__{
        job_id: job.id,
        office_id: id
      }
    end)
  end
end
