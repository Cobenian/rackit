defmodule Rackit.Cable do
  use Rackit.Web, :model

  schema "cables" do
    field :serial, :string
    belongs_to :port_a, Rackit.Port
    belongs_to :port_b, Rackit.Port

    timestamps
  end

  @required_fields ~w(serial port_a_id port_b_id)
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
