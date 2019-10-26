defmodule Greenhousex.Harvest.Application do
  use TypedStruct

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
      applied_at: to_date(map["applied_at"]),
      last_activity_at: to_date(map["last_activity_at"]),
      rejected_at: to_date(map["rejected_at"])
    }
  end

  defp to_date(nil), do: nil

  defp to_date(value) do
    with {:ok, datetime, _offset} <- DateTime.from_iso8601(value) do
      DateTime.truncate(datetime, :second)
    else
      _error -> nil
    end
  end
end
