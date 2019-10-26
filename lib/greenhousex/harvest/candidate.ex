defmodule Greenhousex.Harvest.Candidate do
  use TypedStruct

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
