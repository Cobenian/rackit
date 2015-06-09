defmodule Rackit.PowerCordControllerTest do
  use Rackit.ConnCase

  alias Rackit.PowerCord
  @valid_attrs %{power_supply: nil, serial: "some content", socket: nil}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, power_cord_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing power_cords"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, power_cord_path(conn, :new)
    assert html_response(conn, 200) =~ "New power_cord"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, power_cord_path(conn, :create), power_cord: @valid_attrs
    assert redirected_to(conn) == power_cord_path(conn, :index)
    assert Repo.get_by(PowerCord, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, power_cord_path(conn, :create), power_cord: @invalid_attrs
    assert html_response(conn, 200) =~ "New power_cord"
  end

  test "shows chosen resource", %{conn: conn} do
    power_cord = Repo.insert %PowerCord{}
    conn = get conn, power_cord_path(conn, :show, power_cord)
    assert html_response(conn, 200) =~ "Show power_cord"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    power_cord = Repo.insert %PowerCord{}
    conn = get conn, power_cord_path(conn, :edit, power_cord)
    assert html_response(conn, 200) =~ "Edit power_cord"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    power_cord = Repo.insert %PowerCord{}
    conn = put conn, power_cord_path(conn, :update, power_cord), power_cord: @valid_attrs
    assert redirected_to(conn) == power_cord_path(conn, :index)
    assert Repo.get_by(PowerCord, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    power_cord = Repo.insert %PowerCord{}
    conn = put conn, power_cord_path(conn, :update, power_cord), power_cord: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit power_cord"
  end

  test "deletes chosen resource", %{conn: conn} do
    power_cord = Repo.insert %PowerCord{}
    conn = delete conn, power_cord_path(conn, :delete, power_cord)
    assert redirected_to(conn) == power_cord_path(conn, :index)
    refute Repo.get(PowerCord, power_cord.id)
  end
end
