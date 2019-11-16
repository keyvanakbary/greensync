defmodule Greensync.Store.Model.ApplicationJob do
  use Ecto.Schema

  alias Greenhousex.Harvest.Application

  @primary_key false
  schema "application_jobs" do
    field(:application_id, :integer)
    field(:job_id, :integer)
  end

  def from_harvest(%Application{} = application) do
    Enum.map(application.job_ids, fn id ->
      %__MODULE__{
        application_id: application.id,
        job_id: id
      }
    end)
  end
end
