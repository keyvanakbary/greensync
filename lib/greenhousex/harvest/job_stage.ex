defmodule Greenhousex.Harvest.JobStage do
  use TypedStruct

  alias Greenhousex.Harvest.DateTime

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
      created_at: DateTime.from_iso8601(map["created_at"]),
      updated_at: DateTime.from_iso8601(map["updated_at"])
    }
  end
end
