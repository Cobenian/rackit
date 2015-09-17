defmodule Rackit.Circuit do
  use Rackit.Web, :model

  schema "circuits" do
    field :name, :string
    field :amps, :integer
    belongs_to :cage, Rackit.Cage

    timestamps
  end

  @required_fields ~w(name amps cage_id)
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
