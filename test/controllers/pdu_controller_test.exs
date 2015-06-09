defmodule Rackit.PduControllerTest do
  use Rackit.ConnCase

  alias Rackit.Pdu
  @valid_attrs %{circuit: nil, name: "some content", socket_count: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pdu_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pdus"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, pdu_path(conn, :new)
    assert html_response(conn, 200) =~ "New pdu"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, pdu_path(conn, :create), pdu: @valid_attrs
    assert redirected_to(conn) == pdu_path(conn, :index)
    assert Repo.get_by(Pdu, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pdu_path(conn, :create), pdu: @invalid_attrs
    assert html_response(conn, 200) =~ "New pdu"
  end

  test "shows chosen resource", %{conn: conn} do
    pdu = Repo.insert %Pdu{}
    conn = get conn, pdu_path(conn, :show, pdu)
    assert html_response(conn, 200) =~ "Show pdu"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    pdu = Repo.insert %Pdu{}
    conn = get conn, pdu_path(conn, :edit, pdu)
    assert html_response(conn, 200) =~ "Edit pdu"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    pdu = Repo.insert %Pdu{}
    conn = put conn, pdu_path(conn, :update, pdu), pdu: @valid_attrs
    assert redirected_to(conn) == pdu_path(conn, :index)
    assert Repo.get_by(Pdu, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pdu = Repo.insert %Pdu{}
    conn = put conn, pdu_path(conn, :update, pdu), pdu: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit pdu"
  end

  test "deletes chosen resource", %{conn: conn} do
    pdu = Repo.insert %Pdu{}
    conn = delete conn, pdu_path(conn, :delete, pdu)
    assert redirected_to(conn) == pdu_path(conn, :index)
    refute Repo.get(Pdu, pdu.id)
  end
end
