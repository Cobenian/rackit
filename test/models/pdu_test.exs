defmodule Rackit.PduTest do
  use Rackit.ModelCase

  alias Rackit.Pdu

  @valid_attrs %{circuit: nil, name: "some content", socket_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pdu.changeset(%Pdu{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pdu.changeset(%Pdu{}, @invalid_attrs)
    refute changeset.valid?
  end
end
