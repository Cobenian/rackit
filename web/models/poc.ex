defmodule Rackit.Poc do
  use Rackit.Web, :model

  schema "pocs" do
    field :first, :string
    field :last, :string
    field :phone, :string
    field :email, :string
    field :pager, :string
    belongs_to :company, Rackit.Company

    timestamps
  end

  @required_fields ~w(first last phone email pager)
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
