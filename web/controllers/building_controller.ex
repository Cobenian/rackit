defmodule Rackit.BuildingController do
  use Rackit.Web, :controller

  alias Rackit.Building

  plug :scrub_params, "building" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    buildings = Repo.all(Building) |> Repo.preload(:data_center)
    render(conn, "index.html", buildings: buildings)
  end

  def new(conn, _params) do
    changeset = Building.changeset(%Building{})
    data_centers = Repo.all(Rackit.DataCenter)
    render(conn, "new.html", changeset: changeset, data_centers: data_centers)
  end

  def create(conn, %{"building" => building_params}) do
    changeset = Building.changeset(%Building{}, building_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Building created successfully.")
      |> redirect(to: building_path(conn, :index))
    else
      data_centers = Repo.all(Rackit.DataCenter)
      render(conn, "new.html", changeset: changeset, data_centers: data_centers)
    end
  end

  def show(conn, %{"id" => id}) do
    building = Repo.get(Building, id) |> Repo.preload(:data_center)
    render(conn, "show.html", building: building)
  end

  def edit(conn, %{"id" => id}) do
    building = Repo.get(Building, id) |> Repo.preload(:data_center)
    changeset = Building.changeset(building)
    data_centers = Repo.all(Rackit.DataCenter)
    render(conn, "edit.html", building: building, changeset: changeset, data_centers: data_centers)
  end

  def update(conn, %{"id" => id, "building" => building_params}) do
    building = Repo.get(Building, id) |> Repo.preload(:data_center)
    changeset = Building.changeset(building, building_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Building updated successfully.")
      |> redirect(to: building_path(conn, :index))
    else
      data_centers = Repo.all(Rackit.DataCenter)
      render(conn, "edit.html", building: building, changeset: changeset, data_centers: data_centers)
    end
  end

  def delete(conn, %{"id" => id}) do
    building = Repo.get(Building, id)
    Repo.delete(building)

    conn
    |> put_flash(:info, "Building deleted successfully.")
    |> redirect(to: building_path(conn, :index))
  end
end
