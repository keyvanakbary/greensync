defmodule Greenhousex.Harvest.DateTime do
  def from_iso8601(nil), do: nil

  def from_iso8601(value) do
    with {:ok, datetime, _offset} <- DateTime.from_iso8601(value) do
      datetime
    else
      _error -> nil
    end
  end
end
