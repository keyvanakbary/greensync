defmodule Greensync.Store.Model.Scorecard do
  use Ecto.Schema

  alias Greenhousex.Harvest.Scorecard

  schema "scorecards" do
    field(:candidate_id, :integer)
    field(:application_id, :integer)
    field(:overall_recommendation)
    field(:submitter_id, :integer)
    field(:submitted_at, :utc_datetime)
    field(:interview)
    field(:interviewer_id, :integer)
    field(:interviewed_at, :utc_datetime)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  def from_harvest(%Scorecard{} = scorecard) do
    %__MODULE__{
      id: scorecard.id,
      candidate_id: scorecard.candidate_id,
      application_id: scorecard.application_id,
      overall_recommendation: scorecard.overall_recommendation,
      submitter_id: scorecard.submitter_id,
      submitted_at: scorecard.submitted_at,
      interview: scorecard.interview,
      interviewer_id: scorecard.interviewer_id,
      interviewed_at: scorecard.interviewed_at,
      updated_at: scorecard.updated_at,
      created_at: scorecard.created_at
    }
  end
end
