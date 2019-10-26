defmodule Greensync.Store.Model.JobStage do
  use Ecto.Schema

  alias Greenhousex.Harvest.JobStage

  schema "job_stages" do
    field(:name)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:job_id, :integer)
  end

  def from_harvest(%JobStage{} = job_stage) do
    %__MODULE__{
      id: job_stage.id,
      name: job_stage.name,
      job_id: job_stage.job_id,
      created_at: job_stage.created_at,
      updated_at: job_stage.updated_at
    }
  end
end
