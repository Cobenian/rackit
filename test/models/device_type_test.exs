defmodule Rackit.DeviceTypeTest do
  use Rackit.ModelCase

  alias Rackit.DeviceType

  @valid_attrs %{code: "some content", description: "some content", disabled: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DeviceType.changeset(%DeviceType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DeviceType.changeset(%DeviceType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
