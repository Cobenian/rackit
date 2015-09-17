defmodule Rackit.TransitControllerTest do
  use Rackit.ConnCase

  alias Rackit.Transit
  @valid_attrs %{cage: nil, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, transit_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing transits"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, transit_path(conn, :new)
    assert html_response(conn, 200) =~ "New transit"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, transit_path(conn, :create), transit: @valid_attrs
    assert redirected_to(conn) == transit_path(conn, :index)
    assert Repo.get_by(Transit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, transit_path(conn, :create), transit: @invalid_attrs
    assert html_response(conn, 200) =~ "New transit"
  end

  test "shows chosen resource", %{conn: conn} do
    transit = Repo.insert %Transit{}
    conn = get conn, transit_path(conn, :show, transit)
    assert html_response(conn, 200) =~ "Show transit"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    transit = Repo.insert %Transit{}
    conn = get conn, transit_path(conn, :edit, transit)
    assert html_response(conn, 200) =~ "Edit transit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    transit = Repo.insert %Transit{}
    conn = put conn, transit_path(conn, :update, transit), transit: @valid_attrs
    assert redirected_to(conn) == transit_path(conn, :index)
    assert Repo.get_by(Transit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    transit = Repo.insert %Transit{}
    conn = put conn, transit_path(conn, :update, transit), transit: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit transit"
  end

  test "deletes chosen resource", %{conn: conn} do
    transit = Repo.insert %Transit{}
    conn = delete conn, transit_path(conn, :delete, transit)
    assert redirected_to(conn) == transit_path(conn, :index)
    refute Repo.get(Transit, transit.id)
  end
end
