defmodule Greensync.Store.Model.Application do
  use Ecto.Schema

  alias Greenhousex.Harvest.Application
  alias Greensync.Store.Model.DateTime

  schema "applications" do
    field(:prospect, :boolean)
    field(:status, :string)
    field(:applied_at, :utc_datetime)
    field(:last_activity_at, :utc_datetime)
    field(:rejected_at, :utc_datetime)
    field(:candidate_id, :integer)
    field(:current_stage_id, :integer)
    field(:prospective_office_id, :integer)
    field(:prospective_department_id, :integer)
  end

  def from_harvest(%Application{} = application) do
    %__MODULE__{
      id: application.id,
      prospect: application.prospect,
      candidate_id: application.candidate_id,
      status: application.status,
      current_stage_id: application.current_stage_id,
      applied_at: DateTime.normalize(application.applied_at),
      last_activity_at: DateTime.normalize(application.last_activity_at),
      prospective_office_id: application.prospective_office_id,
      prospective_department_id: application.prospective_department_id,
      rejected_at: DateTime.normalize(application.rejected_at)
    }
  end
end
