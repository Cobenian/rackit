defmodule Rackit.Slot do
  use Rackit.Web, :model

  schema "slots" do
    field :position, :integer
    belongs_to :rack, Rackit.Rack
    belongs_to :device, Rackit.Device

    timestamps
  end

  @required_fields ~w(position rack_id)
  @optional_fields ~w(device_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
