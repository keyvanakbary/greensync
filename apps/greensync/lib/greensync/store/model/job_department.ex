defmodule Greensync.Store.Model.JobDepartment do
  use Ecto.Schema

  alias Greenhousex.Harvest.Job

  @primary_key false
  schema "job_departments" do
    field(:job_id, :integer)
    field(:department_id, :integer)
  end

  def from_harvest(%Job{} = job) do
    Enum.map(job.department_ids, fn id ->
      %__MODULE__{
        job_id: job.id,
        department_id: id
      }
    end)
  end
end
