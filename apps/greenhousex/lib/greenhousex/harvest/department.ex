defmodule Greenhousex.Harvest.Department do
  use TypedStruct

  typedstruct do
    field(:id, integer, enforce: true)
    field(:name, enforce: true)
    field(:parent_id, integer, enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      name: map["name"],
      parent_id: map["parent_id"]
    }
  end
end
