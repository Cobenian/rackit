defmodule Rackit.CageControllerTest do
  use Rackit.ConnCase

  alias Rackit.Cage
  @valid_attrs %{name: "some content", room: nil}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cage_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cages"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cage_path(conn, :new)
    assert html_response(conn, 200) =~ "New cage"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, cage_path(conn, :create), cage: @valid_attrs
    assert redirected_to(conn) == cage_path(conn, :index)
    assert Repo.get_by(Cage, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cage_path(conn, :create), cage: @invalid_attrs
    assert html_response(conn, 200) =~ "New cage"
  end

  test "shows chosen resource", %{conn: conn} do
    cage = Repo.insert %Cage{}
    conn = get conn, cage_path(conn, :show, cage)
    assert html_response(conn, 200) =~ "Show cage"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cage = Repo.insert %Cage{}
    conn = get conn, cage_path(conn, :edit, cage)
    assert html_response(conn, 200) =~ "Edit cage"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cage = Repo.insert %Cage{}
    conn = put conn, cage_path(conn, :update, cage), cage: @valid_attrs
    assert redirected_to(conn) == cage_path(conn, :index)
    assert Repo.get_by(Cage, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cage = Repo.insert %Cage{}
    conn = put conn, cage_path(conn, :update, cage), cage: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cage"
  end

  test "deletes chosen resource", %{conn: conn} do
    cage = Repo.insert %Cage{}
    conn = delete conn, cage_path(conn, :delete, cage)
    assert redirected_to(conn) == cage_path(conn, :index)
    refute Repo.get(Cage, cage.id)
  end
end
