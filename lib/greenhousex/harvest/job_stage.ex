defmodule Greenhousex.Harvest.JobStage do
  use TypedStruct

  typedstruct do
    field(:id, integer, enforce: true)
    field(:name, String.t(), enforce: true)
    field(:job_id, integer, enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      name: map["name"],
      job_id: map["job_id"],
      created_at: to_date(map["created_at"]),
      updated_at: to_date(map["updated_at"])
    }
  end

  defp to_date(value) do
    with {:ok, datetime, _offset} <- DateTime.from_iso8601(value) do
      DateTime.truncate(datetime, :second)
    else
      _error -> nil
    end
  end
end
