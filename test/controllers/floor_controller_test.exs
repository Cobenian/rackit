defmodule Rackit.FloorControllerTest do
  use Rackit.ConnCase

  alias Rackit.Floor
  @valid_attrs %{building: nil, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, floor_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing floors"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, floor_path(conn, :new)
    assert html_response(conn, 200) =~ "New floor"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, floor_path(conn, :create), floor: @valid_attrs
    assert redirected_to(conn) == floor_path(conn, :index)
    assert Repo.get_by(Floor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, floor_path(conn, :create), floor: @invalid_attrs
    assert html_response(conn, 200) =~ "New floor"
  end

  test "shows chosen resource", %{conn: conn} do
    floor = Repo.insert %Floor{}
    conn = get conn, floor_path(conn, :show, floor)
    assert html_response(conn, 200) =~ "Show floor"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    floor = Repo.insert %Floor{}
    conn = get conn, floor_path(conn, :edit, floor)
    assert html_response(conn, 200) =~ "Edit floor"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    floor = Repo.insert %Floor{}
    conn = put conn, floor_path(conn, :update, floor), floor: @valid_attrs
    assert redirected_to(conn) == floor_path(conn, :index)
    assert Repo.get_by(Floor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    floor = Repo.insert %Floor{}
    conn = put conn, floor_path(conn, :update, floor), floor: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit floor"
  end

  test "deletes chosen resource", %{conn: conn} do
    floor = Repo.insert %Floor{}
    conn = delete conn, floor_path(conn, :delete, floor)
    assert redirected_to(conn) == floor_path(conn, :index)
    refute Repo.get(Floor, floor.id)
  end
end
