defmodule Rackit.Pdu do
  use Rackit.Web, :model

  schema "pdus" do
    field :name, :string
    field :socket_count, :integer
    belongs_to :circuit, Rackit.Circuit

    timestamps
  end

  @required_fields ~w(name socket_count circuit_id)
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
