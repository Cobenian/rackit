defmodule Rackit.CageController do
  use Rackit.Web, :controller

  alias Rackit.Cage

  plug :scrub_params, "cage" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    cages = Repo.all(Cage) |> Enum.map(fn(cage) ->
      cage |> Repo.preload(:room)
    end)
    render(conn, "index.html", cages: cages)
  end

  def new(conn, _params) do
    changeset = Cage.changeset(%Cage{})
    rooms = Repo.all(Rackit.Room)
    render(conn, "new.html", changeset: changeset, rooms: rooms)
  end

  def create(conn, %{"cage" => cage_params}) do
    changeset = Cage.changeset(%Cage{}, cage_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Cage created successfully.")
      |> redirect(to: cage_path(conn, :index))
    else
      rooms = Repo.all(Rackit.Room)
      render(conn, "new.html", changeset: changeset, rooms: rooms)
    end
  end

  def show(conn, %{"id" => id}) do
    cage = Repo.get(Cage, id) |> Repo.preload(:room)
    render(conn, "show.html", cage: cage)
  end

  def edit(conn, %{"id" => id}) do
    cage = Repo.get(Cage, id) |> Repo.preload(:room)
    changeset = Cage.changeset(cage)
    rooms = Repo.all(Rackit.Room)
    render(conn, "edit.html", cage: cage, changeset: changeset, rooms: rooms)
  end

  def update(conn, %{"id" => id, "cage" => cage_params}) do
    cage = Repo.get(Cage, id) |> Repo.preload(:room)
    changeset = Cage.changeset(cage, cage_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Cage updated successfully.")
      |> redirect(to: cage_path(conn, :index))
    else
      rooms = Repo.all(Rackit.Room)
      render(conn, "edit.html", cage: cage, changeset: changeset, rooms: rooms)
    end
  end

  def delete(conn, %{"id" => id}) do
    cage = Repo.get(Cage, id)
    Repo.delete(cage)

    conn
    |> put_flash(:info, "Cage deleted successfully.")
    |> redirect(to: cage_path(conn, :index))
  end
end
