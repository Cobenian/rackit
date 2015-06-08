defmodule Rackit.BuildingControllerTest do
  use Rackit.ConnCase

  alias Rackit.Building
  @valid_attrs %{city: "some content", country: "some content", data_center: nil, name: "some content", note: "some content", state: "some content", street1: "some content", street2: "some content", zip: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, building_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing buildings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, building_path(conn, :new)
    assert html_response(conn, 200) =~ "New building"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, building_path(conn, :create), building: @valid_attrs
    assert redirected_to(conn) == building_path(conn, :index)
    assert Repo.get_by(Building, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, building_path(conn, :create), building: @invalid_attrs
    assert html_response(conn, 200) =~ "New building"
  end

  test "shows chosen resource", %{conn: conn} do
    building = Repo.insert %Building{}
    conn = get conn, building_path(conn, :show, building)
    assert html_response(conn, 200) =~ "Show building"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    building = Repo.insert %Building{}
    conn = get conn, building_path(conn, :edit, building)
    assert html_response(conn, 200) =~ "Edit building"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    building = Repo.insert %Building{}
    conn = put conn, building_path(conn, :update, building), building: @valid_attrs
    assert redirected_to(conn) == building_path(conn, :index)
    assert Repo.get_by(Building, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    building = Repo.insert %Building{}
    conn = put conn, building_path(conn, :update, building), building: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit building"
  end

  test "deletes chosen resource", %{conn: conn} do
    building = Repo.insert %Building{}
    conn = delete conn, building_path(conn, :delete, building)
    assert redirected_to(conn) == building_path(conn, :index)
    refute Repo.get(Building, building.id)
  end
end
