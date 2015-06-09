defmodule Rackit.SlotControllerTest do
  use Rackit.ConnCase

  alias Rackit.Slot
  @valid_attrs %{position: 42, rack: nil}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, slot_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing slots"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, slot_path(conn, :new)
    assert html_response(conn, 200) =~ "New slot"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, slot_path(conn, :create), slot: @valid_attrs
    assert redirected_to(conn) == slot_path(conn, :index)
    assert Repo.get_by(Slot, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, slot_path(conn, :create), slot: @invalid_attrs
    assert html_response(conn, 200) =~ "New slot"
  end

  test "shows chosen resource", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = get conn, slot_path(conn, :show, slot)
    assert html_response(conn, 200) =~ "Show slot"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = get conn, slot_path(conn, :edit, slot)
    assert html_response(conn, 200) =~ "Edit slot"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = put conn, slot_path(conn, :update, slot), slot: @valid_attrs
    assert redirected_to(conn) == slot_path(conn, :index)
    assert Repo.get_by(Slot, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = put conn, slot_path(conn, :update, slot), slot: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit slot"
  end

  test "deletes chosen resource", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = delete conn, slot_path(conn, :delete, slot)
    assert redirected_to(conn) == slot_path(conn, :index)
    refute Repo.get(Slot, slot.id)
  end
end
