defmodule Rackit.CircuitController do
  use Rackit.Web, :controller

  alias Rackit.Circuit

  plug :scrub_params, "circuit" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    circuits = Repo.all(Circuit) |> Enum.map(fn(circuit) ->
      circuit |> Repo.preload(:cage)
    end)
    render(conn, "index.html", circuits: circuits)
  end

  def new(conn, _params) do
    changeset = Circuit.changeset(%Circuit{})
    cages = Repo.all(Rackit.Cage)
    render(conn, "new.html", changeset: changeset, cages: cages)
  end

  def create(conn, %{"circuit" => circuit_params}) do
    changeset = Circuit.changeset(%Circuit{}, circuit_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Circuit created successfully.")
      |> redirect(to: circuit_path(conn, :index))
    else
      cages = Repo.all(Rackit.Cage)
      render(conn, "new.html", changeset: changeset, cages: cages)
    end
  end

  def show(conn, %{"id" => id}) do
    circuit = Repo.get(Circuit, id) |> Repo.preload(:cage)
    render(conn, "show.html", circuit: circuit)
  end

  def edit(conn, %{"id" => id}) do
    circuit = Repo.get(Circuit, id) |> Repo.preload(:cage)
    changeset = Circuit.changeset(circuit)
    cages = Repo.all(Rackit.Cage)
    render(conn, "edit.html", circuit: circuit, changeset: changeset, cages: cages)
  end

  def update(conn, %{"id" => id, "circuit" => circuit_params}) do
    circuit = Repo.get(Circuit, id) |> Repo.preload(:cage)
    changeset = Circuit.changeset(circuit, circuit_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Circuit updated successfully.")
      |> redirect(to: circuit_path(conn, :index))
    else
      cages = Repo.all(Rackit.Cage)
      render(conn, "edit.html", circuit: circuit, changeset: changeset, cages: cages)
    end
  end

  def delete(conn, %{"id" => id}) do
    circuit = Repo.get(Circuit, id)
    Repo.delete(circuit)

    conn
    |> put_flash(:info, "Circuit deleted successfully.")
    |> redirect(to: circuit_path(conn, :index))
  end
end
