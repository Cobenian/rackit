defmodule Rackit.CableTest do
  use Rackit.ModelCase

  alias Rackit.Cable

  @valid_attrs %{port: nil, serial: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cable.changeset(%Cable{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cable.changeset(%Cable{}, @invalid_attrs)
    refute changeset.valid?
  end
end
