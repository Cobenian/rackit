defmodule Rackit.FloorController do
  use Rackit.Web, :controller

  alias Rackit.Floor

  plug :scrub_params, "floor" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    floors = Repo.all(Floor) |> Enum.map(fn(floor) ->
      floor |> Repo.preload(:building)
    end)
    render(conn, "index.html", floors: floors)
  end

  def new(conn, _params) do
    changeset = Floor.changeset(%Floor{})
    buildings = Repo.all(Rackit.Building)
    render(conn, "new.html", changeset: changeset, buildings: buildings)
  end

  def create(conn, %{"floor" => floor_params}) do
    changeset = Floor.changeset(%Floor{}, floor_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Floor created successfully.")
      |> redirect(to: floor_path(conn, :index))
    else
      buildings = Repo.all(Rackit.Building)
      render(conn, "new.html", changeset: changeset, buildings: buildings)
    end
  end

  def show(conn, %{"id" => id}) do
    floor = Repo.get(Floor, id) |> Repo.preload(:building)
    render(conn, "show.html", floor: floor)
  end

  def edit(conn, %{"id" => id}) do
    floor = Repo.get(Floor, id) |> Repo.preload(:building)
    changeset = Floor.changeset(floor)
    buildings = Repo.all(Rackit.Building)
    render(conn, "edit.html", floor: floor, changeset: changeset, buildings: buildings)
  end

  def update(conn, %{"id" => id, "floor" => floor_params}) do
    floor = Repo.get(Floor, id) |> Repo.preload(:building)
    changeset = Floor.changeset(floor, floor_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Floor updated successfully.")
      |> redirect(to: floor_path(conn, :index))
    else
      buildings = Repo.all(Rackit.Building)
      render(conn, "edit.html", floor: floor, changeset: changeset, buildings: buildings)
    end
  end

  def delete(conn, %{"id" => id}) do
    floor = Repo.get(Floor, id)
    Repo.delete(floor)

    conn
    |> put_flash(:info, "Floor deleted successfully.")
    |> redirect(to: floor_path(conn, :index))
  end
end
