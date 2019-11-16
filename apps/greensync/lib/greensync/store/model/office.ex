defmodule Greensync.Store.Model.Office do
  use Ecto.Schema

  alias Greenhousex.Harvest.Office

  schema "offices" do
    field(:name)
    field(:location_name)
    field(:parent_id, :integer)
  end

  def from_harvest(%Office{} = office) do
    %__MODULE__{
      id: office.id,
      name: office.name,
      location_name: office.location_name,
      parent_id: office.parent_id
    }
  end
end
