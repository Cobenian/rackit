defmodule Rackit.Port do
  use Rackit.Web, :model

  schema "ports" do
    field :name, :string
    belongs_to :transit, Rackit.Transit
    belongs_to :device, Rackit.Device
    belongs_to :pdu, Rackit.Pdu

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(transit_id device_id pdu_id)

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
