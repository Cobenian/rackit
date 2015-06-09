defmodule Rackit.PowerCord do
  use Rackit.Web, :model

  schema "power_cords" do
    field :serial, :string
    belongs_to :power_supply, Rackit.PowerSupply
    belongs_to :socket, Rackit.Socket

    timestamps
  end

  @required_fields ~w(serial power_supply_id socket_id)
  @optional_fields ~w()

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
