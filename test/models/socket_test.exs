defmodule Rackit.SocketTest do
  use Rackit.ModelCase

  alias Rackit.Socket

  @valid_attrs %{pdu: nil, position: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Socket.changeset(%Socket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Socket.changeset(%Socket{}, @invalid_attrs)
    refute changeset.valid?
  end
end
