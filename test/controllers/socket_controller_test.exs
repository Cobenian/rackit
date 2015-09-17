defmodule Rackit.SocketControllerTest do
  use Rackit.ConnCase

  alias Rackit.Socket
  @valid_attrs %{pdu: nil, position: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, socket_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sockets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, socket_path(conn, :new)
    assert html_response(conn, 200) =~ "New socket"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, socket_path(conn, :create), socket: @valid_attrs
    assert redirected_to(conn) == socket_path(conn, :index)
    assert Repo.get_by(Socket, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, socket_path(conn, :create), socket: @invalid_attrs
    assert html_response(conn, 200) =~ "New socket"
  end

  test "shows chosen resource", %{conn: conn} do
    socket = Repo.insert %Socket{}
    conn = get conn, socket_path(conn, :show, socket)
    assert html_response(conn, 200) =~ "Show socket"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    socket = Repo.insert %Socket{}
    conn = get conn, socket_path(conn, :edit, socket)
    assert html_response(conn, 200) =~ "Edit socket"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    socket = Repo.insert %Socket{}
    conn = put conn, socket_path(conn, :update, socket), socket: @valid_attrs
    assert redirected_to(conn) == socket_path(conn, :index)
    assert Repo.get_by(Socket, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    socket = Repo.insert %Socket{}
    conn = put conn, socket_path(conn, :update, socket), socket: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit socket"
  end

  test "deletes chosen resource", %{conn: conn} do
    socket = Repo.insert %Socket{}
    conn = delete conn, socket_path(conn, :delete, socket)
    assert redirected_to(conn) == socket_path(conn, :index)
    refute Repo.get(Socket, socket.id)
  end
end
