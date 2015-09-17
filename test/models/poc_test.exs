defmodule Rackit.PocTest do
  use Rackit.ModelCase

  alias Rackit.Poc

  @valid_attrs %{company: nil, email: "some content", first: "some content", last: "some content", pager: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Poc.changeset(%Poc{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Poc.changeset(%Poc{}, @invalid_attrs)
    refute changeset.valid?
  end
end
