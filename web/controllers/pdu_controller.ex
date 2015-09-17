defmodule Rackit.PduController do
  use Rackit.Web, :controller

  alias Rackit.Pdu

  plug :scrub_params, "pdu" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    pdus = Repo.all(Pdu) |> Enum.map(fn(pdu) ->
      pdu |> Repo.preload(:circuit)
    end)
    render(conn, "index.html", pdus: pdus)
  end

  def new(conn, _params) do
    changeset = Pdu.changeset(%Pdu{})
    circuits = Repo.all(Rackit.Circuit)
    render(conn, "new.html", changeset: changeset, circuits: circuits)
  end

  def create(conn, %{"pdu" => pdu_params}) do
    changeset = Pdu.changeset(%Pdu{}, pdu_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Pdu created successfully.")
      |> redirect(to: pdu_path(conn, :index))
    else
      circuits = Repo.all(Rackit.Circuit)
      render(conn, "new.html", changeset: changeset, circuits: circuits)
    end
  end

  def show(conn, %{"id" => id}) do
    pdu = Repo.get(Pdu, id) |> Repo.preload(:circuit)
    render(conn, "show.html", pdu: pdu)
  end

  def edit(conn, %{"id" => id}) do
    pdu = Repo.get(Pdu, id) |> Repo.preload(:circuit)
    changeset = Pdu.changeset(pdu)
    circuits = Repo.all(Rackit.Circuit)
    render(conn, "edit.html", pdu: pdu, changeset: changeset, circuits: circuits)
  end

  def update(conn, %{"id" => id, "pdu" => pdu_params}) do
    pdu = Repo.get(Pdu, id) |> Repo.preload(:circuit)
    changeset = Pdu.changeset(pdu, pdu_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Pdu updated successfully.")
      |> redirect(to: pdu_path(conn, :index))
    else
      circuits = Repo.all(Rackit.Circuit)
      render(conn, "edit.html", pdu: pdu, changeset: changeset, circuits: circuits)
    end
  end

  def delete(conn, %{"id" => id}) do
    pdu = Repo.get(Pdu, id)
    Repo.delete(pdu)

    conn
    |> put_flash(:info, "Pdu deleted successfully.")
    |> redirect(to: pdu_path(conn, :index))
  end
end
