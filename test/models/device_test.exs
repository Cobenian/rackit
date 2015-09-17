defmodule Rackit.DeviceTest do
  use Rackit.ModelCase

  alias Rackit.Device

  @valid_attrs %{data_center: "some content", device_type: "some content", drives_bad: 42, drives_empty: 42, drives_in_use: 42, name: "some content", ports_bad: 42, ports_empty: 42, ports_in_use: 42, power_bad: 42, power_empty: 42, power_in_use: 42}
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
