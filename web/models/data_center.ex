defmodule Rackit.DataCenter do
  use Rackit.Web, :model

  schema "data_centers" do
    field :name, :string
    belongs_to :company, Rackit.Company

    timestamps
  end

  @required_fields ~w(name company_id)
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
