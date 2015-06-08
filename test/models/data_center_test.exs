defmodule Rackit.DataCenterTest do
  use Rackit.ModelCase

  alias Rackit.DataCenter

  @valid_attrs %{company: nil, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DataCenter.changeset(%DataCenter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DataCenter.changeset(%DataCenter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
