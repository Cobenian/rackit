defmodule Rackit.CableControllerTest do
  use Rackit.ConnCase

  alias Rackit.Cable
  @valid_attrs %{port: nil, serial: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cable_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cables"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cable_path(conn, :new)
    assert html_response(conn, 200) =~ "New cable"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, cable_path(conn, :create), cable: @valid_attrs
    assert redirected_to(conn) == cable_path(conn, :index)
    assert Repo.get_by(Cable, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cable_path(conn, :create), cable: @invalid_attrs
    assert html_response(conn, 200) =~ "New cable"
  end

  test "shows chosen resource", %{conn: conn} do
    cable = Repo.insert %Cable{}
    conn = get conn, cable_path(conn, :show, cable)
    assert html_response(conn, 200) =~ "Show cable"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cable = Repo.insert %Cable{}
    conn = get conn, cable_path(conn, :edit, cable)
    assert html_response(conn, 200) =~ "Edit cable"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cable = Repo.insert %Cable{}
    conn = put conn, cable_path(conn, :update, cable), cable: @valid_attrs
    assert redirected_to(conn) == cable_path(conn, :index)
    assert Repo.get_by(Cable, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cable = Repo.insert %Cable{}
    conn = put conn, cable_path(conn, :update, cable), cable: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cable"
  end

  test "deletes chosen resource", %{conn: conn} do
    cable = Repo.insert %Cable{}
    conn = delete conn, cable_path(conn, :delete, cable)
    assert redirected_to(conn) == cable_path(conn, :index)
    refute Repo.get(Cable, cable.id)
  end
end
