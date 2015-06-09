defmodule Rackit.RackTest do
  use Rackit.ModelCase

  alias Rackit.Rack

  @valid_attrs %{cage: nil, name: "some content", slot_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Rack.changeset(%Rack{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Rack.changeset(%Rack{}, @invalid_attrs)
    refute changeset.valid?
  end
end
