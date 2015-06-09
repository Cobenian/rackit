defmodule Rackit.PowerSupplyControllerTest do
  use Rackit.ConnCase

  alias Rackit.PowerSupply
  @valid_attrs %{device: nil, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, power_supply_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing power_supplies"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, power_supply_path(conn, :new)
    assert html_response(conn, 200) =~ "New power_supply"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, power_supply_path(conn, :create), power_supply: @valid_attrs
    assert redirected_to(conn) == power_supply_path(conn, :index)
    assert Repo.get_by(PowerSupply, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, power_supply_path(conn, :create), power_supply: @invalid_attrs
    assert html_response(conn, 200) =~ "New power_supply"
  end

  test "shows chosen resource", %{conn: conn} do
    power_supply = Repo.insert %PowerSupply{}
    conn = get conn, power_supply_path(conn, :show, power_supply)
    assert html_response(conn, 200) =~ "Show power_supply"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    power_supply = Repo.insert %PowerSupply{}
    conn = get conn, power_supply_path(conn, :edit, power_supply)
    assert html_response(conn, 200) =~ "Edit power_supply"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    power_supply = Repo.insert %PowerSupply{}
    conn = put conn, power_supply_path(conn, :update, power_supply), power_supply: @valid_attrs
    assert redirected_to(conn) == power_supply_path(conn, :index)
    assert Repo.get_by(PowerSupply, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    power_supply = Repo.insert %PowerSupply{}
    conn = put conn, power_supply_path(conn, :update, power_supply), power_supply: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit power_supply"
  end

  test "deletes chosen resource", %{conn: conn} do
    power_supply = Repo.insert %PowerSupply{}
    conn = delete conn, power_supply_path(conn, :delete, power_supply)
    assert redirected_to(conn) == power_supply_path(conn, :index)
    refute Repo.get(PowerSupply, power_supply.id)
  end
end
