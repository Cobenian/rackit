defmodule Rackit.CageTest do
  use Rackit.ModelCase

  alias Rackit.Cage

  @valid_attrs %{name: "some content", room: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cage.changeset(%Cage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cage.changeset(%Cage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
