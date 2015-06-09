defmodule Rackit.PortControllerTest do
  use Rackit.ConnCase

  alias Rackit.Port
  @valid_attrs %{device: nil, name: "some content", pdu: nil, transit: nil}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, port_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing ports"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, port_path(conn, :new)
    assert html_response(conn, 200) =~ "New port"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, port_path(conn, :create), port: @valid_attrs
    assert redirected_to(conn) == port_path(conn, :index)
    assert Repo.get_by(Port, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, port_path(conn, :create), port: @invalid_attrs
    assert html_response(conn, 200) =~ "New port"
  end

  test "shows chosen resource", %{conn: conn} do
    port = Repo.insert %Port{}
    conn = get conn, port_path(conn, :show, port)
    assert html_response(conn, 200) =~ "Show port"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    port = Repo.insert %Port{}
    conn = get conn, port_path(conn, :edit, port)
    assert html_response(conn, 200) =~ "Edit port"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    port = Repo.insert %Port{}
    conn = put conn, port_path(conn, :update, port), port: @valid_attrs
    assert redirected_to(conn) == port_path(conn, :index)
    assert Repo.get_by(Port, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    port = Repo.insert %Port{}
    conn = put conn, port_path(conn, :update, port), port: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit port"
  end

  test "deletes chosen resource", %{conn: conn} do
    port = Repo.insert %Port{}
    conn = delete conn, port_path(conn, :delete, port)
    assert redirected_to(conn) == port_path(conn, :index)
    refute Repo.get(Port, port.id)
  end
end
