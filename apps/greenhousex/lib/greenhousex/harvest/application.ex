defmodule Greenhousex.Harvest.Application do
  use TypedStruct

  alias Greenhousex.Harvest.DateTime

  typedstruct do
    field(:id, integer, enforce: true)
    field(:prospect, bool, enforce: true)
    field(:candidate_id, integer, enforce: true)
    field(:status, String.t(), enforce: true)
    field(:job_ids, [integer], enforce: true)
    field(:current_stage_id, integer, enforce: true)
    field(:applied_at, DateTime.t(), enforce: true)
    field(:last_activity_at, DateTime.t(), enforce: true)
    field(:prospective_office_id, integer)
    field(:prospective_department_id, integer)
    field(:rejected_at, DateTime.t())
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      prospect: map["prospect"],
      candidate_id: map["candidate_id"],
      status: map["status"],
      job_ids: map["jobs"] |> Enum.map(& &1["id"]),
      current_stage_id: map["current_stage"]["id"],
      prospective_office_id: map["prospective_office"]["id"],
      prospective_department_id: map["prospective_department"]["id"],
      applied_at: DateTime.from_iso8601(map["applied_at"]),
      last_activity_at: DateTime.from_iso8601(map["last_activity_at"]),
      rejected_at: DateTime.from_iso8601(map["rejected_at"])
    }
  end
end
