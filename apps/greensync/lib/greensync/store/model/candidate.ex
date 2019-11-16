defmodule Greensync.Store.Model.Candidate do
  use Ecto.Schema

  alias Greenhousex.Harvest.Candidate
  alias Greensync.Store.Model.DateTime

  schema "candidates" do
    field(:title)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  def from_harvest(%Candidate{} = candidate) do
    %__MODULE__{
      id: candidate.id,
      # first_name: candidate.first_name, # GDPR
      # last_name: candidate.last_name, # GDPR
      # company: candidate.company, # GDPR
      title: candidate.title,
      updated_at: DateTime.normalize(candidate.updated_at),
      created_at: DateTime.normalize(candidate.created_at)
    }
  end
end
