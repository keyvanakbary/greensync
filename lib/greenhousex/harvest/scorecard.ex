defmodule Greenhousex.Harvest.Scorecard do
  use TypedStruct

  typedstruct do
    field(:id, integer, enforce: true)
    field(:candidate_id, integer, enforce: true)
    field(:application_id, integer, enforce: true)
    field(:overall_recommendation, String.t(), enforce: true)
    field(:submitter_id, integer, enforce: true)
    field(:submitted_at, DateTime.t(), enforce: true)
    field(:interview, String.t(), enforce: true)
    field(:interviewer_id, integer, enforce: true)
    field(:interviewed_at, DateTime.t(), enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      candidate_id: map["candidate_id"],
      application_id: map["application_id"],
      overall_recommendation: map["overall_recommendation"],
      submitter_id: map["submitted_by"]["id"],
      submitted_at: to_date(map["submitted_at"]),
      interview: map["interview"],
      interviewer_id: map["interviewer"]["id"],
      interviewed_at: to_date(map["interviewed_at"]),
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
