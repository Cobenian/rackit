defmodule Rackit.DeviceTypeControllerTest do
  use Rackit.ConnCase

  alias Rackit.DeviceType
  @valid_attrs %{code: "some content", description: "some content", disabled: true, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, device_type_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing device_types"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, device_type_path(conn, :new)
    assert html_response(conn, 200) =~ "New device_type"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, device_type_path(conn, :create), device_type: @valid_attrs
    assert redirected_to(conn) == device_type_path(conn, :index)
    assert Repo.get_by(DeviceType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, device_type_path(conn, :create), device_type: @invalid_attrs
    assert html_response(conn, 200) =~ "New device_type"
  end

  test "shows chosen resource", %{conn: conn} do
    device_type = Repo.insert %DeviceType{}
    conn = get conn, device_type_path(conn, :show, device_type)
    assert html_response(conn, 200) =~ "Show device_type"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    device_type = Repo.insert %DeviceType{}
    conn = get conn, device_type_path(conn, :edit, device_type)
    assert html_response(conn, 200) =~ "Edit device_type"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    device_type = Repo.insert %DeviceType{}
    conn = put conn, device_type_path(conn, :update, device_type), device_type: @valid_attrs
    assert redirected_to(conn) == device_type_path(conn, :index)
    assert Repo.get_by(DeviceType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    device_type = Repo.insert %DeviceType{}
    conn = put conn, device_type_path(conn, :update, device_type), device_type: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit device_type"
  end

  test "deletes chosen resource", %{conn: conn} do
    device_type = Repo.insert %DeviceType{}
    conn = delete conn, device_type_path(conn, :delete, device_type)
    assert redirected_to(conn) == device_type_path(conn, :index)
    refute Repo.get(DeviceType, device_type.id)
  end
end
