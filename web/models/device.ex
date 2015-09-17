defmodule Rackit.Device do
  use Rackit.Web, :model

  schema "devices" do
    field :name, :string
    field :device_type, :string
    field :data_center, :string
    field :power_in_use, :integer
    field :power_empty, :integer
    field :power_bad, :integer
    field :drives_in_use, :integer
    field :drives_empty, :integer
    field :drives_bad, :integer
    field :ports_in_use, :integer
    field :ports_empty, :integer
    field :ports_bad, :integer

    timestamps
  end

  @required_fields ~w(name device_type data_center power_in_use power_empty power_bad drives_in_use drives_empty drives_bad ports_in_use ports_empty ports_bad)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
