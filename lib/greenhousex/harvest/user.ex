defmodule Greenhousex.Harvest.User do
  use TypedStruct

  alias Greenhousex.Harvest.DateTime

  typedstruct do
    field(:id, integer, enforce: true)
    field(:name, String.t(), enforce: true)
    field(:first_name, String.t())
    field(:last_name, String.t())
    field(:primary_email_address, String.t(), enforce: true)
    field(:disabled, bool, enforce: true)
    field(:site_admin, bool, enforce: true)
    field(:created_at, DateTime.t(), enforce: true)
    field(:updated_at, DateTime.t(), enforce: true)
  end

  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) when is_map(map) do
    %__MODULE__{
      id: map["id"],
      name: map["name"],
      first_name: map["first_name"],
      last_name: map["last_name"],
      primary_email_address: map["primary_email_address"],
      disabled: map["disabled"],
      site_admin: map["site_admin"],
      created_at: DateTime.from_iso8601(map["created_at"]),
      updated_at: DateTime.from_iso8601(map["updated_at"])
    }
  end
end
