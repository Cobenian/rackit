defmodule Rackit.DeviceControllerTest do
  use Rackit.ConnCase

  alias Rackit.Device
  @valid_attrs %{data_center: "some content", device_type: "some content", drives_bad: 42, drives_empty: 42, drives_in_use: 42, name: "some content", ports_bad: 42, ports_empty: 42, ports_in_use: 42, power_bad: 42, power_empty: 42, power_in_use: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, device_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = get conn, device_path(conn, :show, device)
    assert json_response(conn, 200)["data"] == %{id: device.id,
      name: device.name,
      device_type: device.device_type,
      data_center: device.data_center,
      power_in_use: device.power_in_use,
      power_empty: device.power_empty,
      power_bad: device.power_bad,
      drives_in_use: device.drives_in_use,
      drives_empty: device.drives_empty,
      drives_bad: device.drives_bad,
      ports_in_use: device.ports_in_use,
      ports_empty: device.ports_empty,
      ports_bad: device.ports_bad}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, device_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, device_path(conn, :create), device: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Device, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, device_path(conn, :create), device: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = put conn, device_path(conn, :update, device), device: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Device, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = put conn, device_path(conn, :update, device), device: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    device = Repo.insert! %Device{}
    conn = delete conn, device_path(conn, :delete, device)
    assert response(conn, 204)
    refute Repo.get(Device, device.id)
  end
end
