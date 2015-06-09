defmodule Rackit.PowerCordTest do
  use Rackit.ModelCase

  alias Rackit.PowerCord

  @valid_attrs %{power_supply: nil, serial: "some content", socket: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PowerCord.changeset(%PowerCord{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PowerCord.changeset(%PowerCord{}, @invalid_attrs)
    refute changeset.valid?
  end
end
