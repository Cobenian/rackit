defmodule Rackit.Room do
  use Rackit.Web, :model

  schema "rooms" do
    field :name, :string
    belongs_to :floor, Rackit.Floor

    timestamps
  end

  @required_fields ~w(name floor_id)
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
