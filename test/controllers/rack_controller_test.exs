defmodule Rackit.RackControllerTest do
  use Rackit.ConnCase

  alias Rackit.Rack
  @valid_attrs %{cage: nil, name: "some content", slot_count: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, rack_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing racks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, rack_path(conn, :new)
    assert html_response(conn, 200) =~ "New rack"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, rack_path(conn, :create), rack: @valid_attrs
    assert redirected_to(conn) == rack_path(conn, :index)
    assert Repo.get_by(Rack, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, rack_path(conn, :create), rack: @invalid_attrs
    assert html_response(conn, 200) =~ "New rack"
  end

  test "shows chosen resource", %{conn: conn} do
    rack = Repo.insert %Rack{}
    conn = get conn, rack_path(conn, :show, rack)
    assert html_response(conn, 200) =~ "Show rack"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    rack = Repo.insert %Rack{}
    conn = get conn, rack_path(conn, :edit, rack)
    assert html_response(conn, 200) =~ "Edit rack"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    rack = Repo.insert %Rack{}
    conn = put conn, rack_path(conn, :update, rack), rack: @valid_attrs
    assert redirected_to(conn) == rack_path(conn, :index)
    assert Repo.get_by(Rack, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    rack = Repo.insert %Rack{}
    conn = put conn, rack_path(conn, :update, rack), rack: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit rack"
  end

  test "deletes chosen resource", %{conn: conn} do
    rack = Repo.insert %Rack{}
    conn = delete conn, rack_path(conn, :delete, rack)
    assert redirected_to(conn) == rack_path(conn, :index)
    refute Repo.get(Rack, rack.id)
  end
end
