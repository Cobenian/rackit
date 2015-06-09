defmodule Rackit.TransitTest do
  use Rackit.ModelCase

  alias Rackit.Transit

  @valid_attrs %{cage: nil, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Transit.changeset(%Transit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Transit.changeset(%Transit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
