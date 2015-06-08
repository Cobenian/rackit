defmodule Rackit.Building do
  use Rackit.Web, :model

  schema "buildings" do
    field :name, :string
    field :street1, :string
    field :street2, :string
    field :city, :string
    field :state, :string
    field :country, :string
    field :zip, :string
    field :note, :string
    belongs_to :data_center, Rackit.DataCenter

    timestamps
  end

  @required_fields ~w(name street1 city state country zip data_center_id)
  @optional_fields ~w(note street2)

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
