defmodule Greensync.Store.Model.Department do
  use Ecto.Schema

  alias Greenhousex.Harvest.Department

  schema "departments" do
    field(:name)
    field(:parent_id, :integer)
  end

  def from_harvest(%Department{} = department) do
    %__MODULE__{
      id: department.id,
      name: department.name,
      parent_id: department.parent_id
    }
  end
end
