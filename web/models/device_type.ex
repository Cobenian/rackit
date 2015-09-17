defmodule Rackit.DeviceType do
  use Rackit.Web, :model

  schema "device_types" do
    field :name, :string
    field :code, :string
    field :description, :string
    field :disabled, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name code description disabled)
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
