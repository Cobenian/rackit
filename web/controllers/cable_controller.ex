defmodule Rackit.CableController do
  use Rackit.Web, :controller

  alias Rackit.Cable

  plug :scrub_params, "cable" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    cables = Repo.all(Cable) |> Enum.map(fn(cable) ->
      cable |> Repo.preload(:port_a) |> Repo.preload(:port_b)
    end)
    render(conn, "index.html", cables: cables)
  end

  def new(conn, _params) do
    changeset = Cable.changeset(%Cable{})
    ports = Repo.all(Rackit.Port)
    render(conn, "new.html", changeset: changeset, ports: ports)
  end

  def create(conn, %{"cable" => cable_params}) do
    changeset = Cable.changeset(%Cable{}, cable_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Cable created successfully.")
      |> redirect(to: cable_path(conn, :index))
    else
      ports = Repo.all(Rackit.Port)
      render(conn, "new.html", changeset: changeset, ports: ports)
    end
  end

  def show(conn, %{"id" => id}) do
    cable = Repo.get(Cable, id) |> Repo.preload(Racket.Port, :port_a) |> Repo.preload(Racket.Port, :port_b)
    render(conn, "show.html", cable: cable)
  end

  def edit(conn, %{"id" => id}) do
    cable = Repo.get(Cable, id) |> Repo.preload(Racket.Port, :port_a) |> Repo.preload(Racket.Port, :port_b)
    changeset = Cable.changeset(cable)
    ports = Repo.all(Rackit.Port)
    render(conn, "edit.html", cable: cable, changeset: changeset, ports: ports)
  end

  def update(conn, %{"id" => id, "cable" => cable_params}) do
    cable = Repo.get(Cable, id) |> Repo.preload(Racket.Port, :port_a) |> Repo.preload(Racket.Port, :port_b)
    changeset = Cable.changeset(cable, cable_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Cable updated successfully.")
      |> redirect(to: cable_path(conn, :index))
    else
      ports = Repo.all(Rackit.Port)
      render(conn, "edit.html", cable: cable, changeset: changeset, ports: ports)
    end
  end

  def delete(conn, %{"id" => id}) do
    cable = Repo.get(Cable, id)
    Repo.delete(cable)

    conn
    |> put_flash(:info, "Cable deleted successfully.")
    |> redirect(to: cable_path(conn, :index))
  end
end
