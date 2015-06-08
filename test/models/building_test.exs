defmodule Rackit.BuildingTest do
  use Rackit.ModelCase

  alias Rackit.Building

  @valid_attrs %{city: "some content", country: "some content", data_center: nil, name: "some content", note: "some content", state: "some content", street1: "some content", street2: "some content", zip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Building.changeset(%Building{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Building.changeset(%Building{}, @invalid_attrs)
    refute changeset.valid?
  end
end
