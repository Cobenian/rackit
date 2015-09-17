defmodule Rackit.Floor do
  use Rackit.Web, :model

  schema "floors" do
    field :name, :string
    belongs_to :building, Rackit.Building

    timestamps
  end

  @required_fields ~w(name building_id)
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
