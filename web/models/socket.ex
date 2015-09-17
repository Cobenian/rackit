defmodule Rackit.Socket do
  use Rackit.Web, :model

  schema "sockets" do
    field :position, :integer
    belongs_to :pdu, Rackit.Pdu

    timestamps
  end

  @required_fields ~w(position pdu_id)
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
