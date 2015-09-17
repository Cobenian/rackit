defmodule Rackit.PocControllerTest do
  use Rackit.ConnCase

  alias Rackit.Poc
  @valid_attrs %{company: nil, email: "some content", first: "some content", last: "some content", pager: "some content", phone: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, poc_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pocs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, poc_path(conn, :new)
    assert html_response(conn, 200) =~ "New poc"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, poc_path(conn, :create), poc: @valid_attrs
    assert redirected_to(conn) == poc_path(conn, :index)
    assert Repo.get_by(Poc, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, poc_path(conn, :create), poc: @invalid_attrs
    assert html_response(conn, 200) =~ "New poc"
  end

  test "shows chosen resource", %{conn: conn} do
    poc = Repo.insert %Poc{}
    conn = get conn, poc_path(conn, :show, poc)
    assert html_response(conn, 200) =~ "Show poc"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    poc = Repo.insert %Poc{}
    conn = get conn, poc_path(conn, :edit, poc)
    assert html_response(conn, 200) =~ "Edit poc"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    poc = Repo.insert %Poc{}
    conn = put conn, poc_path(conn, :update, poc), poc: @valid_attrs
    assert redirected_to(conn) == poc_path(conn, :index)
    assert Repo.get_by(Poc, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    poc = Repo.insert %Poc{}
    conn = put conn, poc_path(conn, :update, poc), poc: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit poc"
  end

  test "deletes chosen resource", %{conn: conn} do
    poc = Repo.insert %Poc{}
    conn = delete conn, poc_path(conn, :delete, poc)
    assert redirected_to(conn) == poc_path(conn, :index)
    refute Repo.get(Poc, poc.id)
  end
end
