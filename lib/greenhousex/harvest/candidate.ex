defmodule Greenhousex.Harvest.Candidate do
  use TypedStruct

  alias Greenhousex.Harvest.DateTime

  typedstruct do
    field(:id, integer, enforce: true)
    field(:first_name, String.t(), enforce: true)
    field(:last_name, String.t(), enforce: true)
    field(:company, String.t(), enforce: true)
    field(:title, String.t(), enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      first_name: map["first_name"],
      last_name: map["last_name"],
      company: map["company"],
      title: map["title"],
      created_at: DateTime.from_iso8601(map["created_at"]),
      updated_at: DateTime.from_iso8601(map["updated_at"])
    }
  end
end
