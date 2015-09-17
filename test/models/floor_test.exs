defmodule Rackit.FloorTest do
  use Rackit.ModelCase

  alias Rackit.Floor

  @valid_attrs %{building: nil, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Floor.changeset(%Floor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Floor.changeset(%Floor{}, @invalid_attrs)
    refute changeset.valid?
  end
end
