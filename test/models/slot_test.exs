defmodule Rackit.SlotTest do
  use Rackit.ModelCase

  alias Rackit.Slot

  @valid_attrs %{position: 42, rack: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Slot.changeset(%Slot{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Slot.changeset(%Slot{}, @invalid_attrs)
    refute changeset.valid?
  end
end
