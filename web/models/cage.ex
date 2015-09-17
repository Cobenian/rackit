defmodule Rackit.Cage do
  use Rackit.Web, :model

  schema "cages" do
    field :name, :string
    belongs_to :room, Rackit.Room

    timestamps
  end

  @required_fields ~w(name room_id)
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
