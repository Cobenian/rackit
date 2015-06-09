defmodule Rackit.PortTest do
  use Rackit.ModelCase

  alias Rackit.Port

  @valid_attrs %{device: nil, name: "some content", pdu: nil, transit: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Port.changeset(%Port{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Port.changeset(%Port{}, @invalid_attrs)
    refute changeset.valid?
  end
end
