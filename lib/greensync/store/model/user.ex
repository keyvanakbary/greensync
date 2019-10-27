defmodule Greensync.Store.Model.User do
  use Ecto.Schema

  alias Greenhousex.Harvest.User
  alias Greensync.Store.Model.DateTime

  schema "users" do
    field(:name)
    field(:first_name)
    field(:last_name)
    field(:primary_email_address)
    field(:disabled, :boolean)
    field(:site_admin, :boolean)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  def from_harvest(%User{} = user) do
    %__MODULE__{
      id: user.id,
      name: user.name,
      first_name: user.first_name,
      last_name: user.last_name,
      primary_email_address: user.primary_email_address,
      disabled: user.disabled,
      site_admin: user.site_admin,
      updated_at: DateTime.normalize(user.updated_at),
      created_at: DateTime.normalize(user.created_at)
    }
  end
end
