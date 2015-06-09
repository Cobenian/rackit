defmodule Rackit.CircuitControllerTest do
  use Rackit.ConnCase

  alias Rackit.Circuit
  @valid_attrs %{amps: 42, cage: nil, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, circuit_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing circuits"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, circuit_path(conn, :new)
    assert html_response(conn, 200) =~ "New circuit"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, circuit_path(conn, :create), circuit: @valid_attrs
    assert redirected_to(conn) == circuit_path(conn, :index)
    assert Repo.get_by(Circuit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, circuit_path(conn, :create), circuit: @invalid_attrs
    assert html_response(conn, 200) =~ "New circuit"
  end

  test "shows chosen resource", %{conn: conn} do
    circuit = Repo.insert %Circuit{}
    conn = get conn, circuit_path(conn, :show, circuit)
    assert html_response(conn, 200) =~ "Show circuit"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    circuit = Repo.insert %Circuit{}
    conn = get conn, circuit_path(conn, :edit, circuit)
    assert html_response(conn, 200) =~ "Edit circuit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    circuit = Repo.insert %Circuit{}
    conn = put conn, circuit_path(conn, :update, circuit), circuit: @valid_attrs
    assert redirected_to(conn) == circuit_path(conn, :index)
    assert Repo.get_by(Circuit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    circuit = Repo.insert %Circuit{}
    conn = put conn, circuit_path(conn, :update, circuit), circuit: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit circuit"
  end

  test "deletes chosen resource", %{conn: conn} do
    circuit = Repo.insert %Circuit{}
    conn = delete conn, circuit_path(conn, :delete, circuit)
    assert redirected_to(conn) == circuit_path(conn, :index)
    refute Repo.get(Circuit, circuit.id)
  end
end
