defmodule Rackit.DataCenterControllerTest do
  use Rackit.ConnCase

  alias Rackit.DataCenter
  @valid_attrs %{company: nil, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, data_center_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing data_centers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, data_center_path(conn, :new)
    assert html_response(conn, 200) =~ "New data_center"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, data_center_path(conn, :create), data_center: @valid_attrs
    assert redirected_to(conn) == data_center_path(conn, :index)
    assert Repo.get_by(DataCenter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, data_center_path(conn, :create), data_center: @invalid_attrs
    assert html_response(conn, 200) =~ "New data_center"
  end

  test "shows chosen resource", %{conn: conn} do
    data_center = Repo.insert %DataCenter{}
    conn = get conn, data_center_path(conn, :show, data_center)
    assert html_response(conn, 200) =~ "Show data_center"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    data_center = Repo.insert %DataCenter{}
    conn = get conn, data_center_path(conn, :edit, data_center)
    assert html_response(conn, 200) =~ "Edit data_center"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    data_center = Repo.insert %DataCenter{}
    conn = put conn, data_center_path(conn, :update, data_center), data_center: @valid_attrs
    assert redirected_to(conn) == data_center_path(conn, :index)
    assert Repo.get_by(DataCenter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    data_center = Repo.insert %DataCenter{}
    conn = put conn, data_center_path(conn, :update, data_center), data_center: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit data_center"
  end

  test "deletes chosen resource", %{conn: conn} do
    data_center = Repo.insert %DataCenter{}
    conn = delete conn, data_center_path(conn, :delete, data_center)
    assert redirected_to(conn) == data_center_path(conn, :index)
    refute Repo.get(DataCenter, data_center.id)
  end
end
