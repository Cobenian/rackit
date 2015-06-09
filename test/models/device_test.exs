defmodule Rackit.DeviceTest do
  use Rackit.ModelCase

  alias Rackit.Device

  @valid_attrs %{device_type: nil, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Device.changeset(%Device{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Device.changeset(%Device{}, @invalid_attrs)
    refute changeset.valid?
  end
end
