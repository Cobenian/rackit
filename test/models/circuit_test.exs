defmodule Rackit.CircuitTest do
  use Rackit.ModelCase

  alias Rackit.Circuit

  @valid_attrs %{amps: 42, cage: nil, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Circuit.changeset(%Circuit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Circuit.changeset(%Circuit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
