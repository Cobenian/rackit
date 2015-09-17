defmodule Rackit.PowerSupplyTest do
  use Rackit.ModelCase

  alias Rackit.PowerSupply

  @valid_attrs %{device: nil, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PowerSupply.changeset(%PowerSupply{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PowerSupply.changeset(%PowerSupply{}, @invalid_attrs)
    refute changeset.valid?
  end
end
