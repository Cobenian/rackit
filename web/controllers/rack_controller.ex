defmodule Rackit.RackController do
  use Rackit.Web, :controller

  alias Rackit.Rack

  plug :scrub_params, "rack" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    racks = Repo.all(Rack) |> Enum.map(fn(rack) ->
      rack |> Repo.preload(:cage)
    end)
    render(conn, "index.html", racks: racks)
  end

  def new(conn, _params) do
    changeset = Rack.changeset(%Rack{})
    cages = Repo.all(Rackit.Cage)
    render(conn, "new.html", changeset: changeset, cages: cages)
  end

  def create(conn, %{"rack" => rack_params}) do
    changeset = Rack.changeset(%Rack{}, rack_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Rack created successfully.")
      |> redirect(to: rack_path(conn, :index))
    else
      cages = Repo.all(Rackit.Cage)
      render(conn, "new.html", changeset: changeset, cages: cages)
    end
  end

  def show(conn, %{"id" => id}) do
    rack = Repo.get(Rack, id) |> Repo.preload(:cage)
    render(conn, "show.html", rack: rack)
  end

  def edit(conn, %{"id" => id}) do
    rack = Repo.get(Rack, id) |> Repo.preload(:cage)
    changeset = Rack.changeset(rack)
    cages = Repo.all(Rackit.Cage)
    render(conn, "edit.html", rack: rack, changeset: changeset, cages: cages)
  end

  def update(conn, %{"id" => id, "rack" => rack_params}) do
    rack = Repo.get(Rack, id) |> Repo.preload(:cage)
    changeset = Rack.changeset(rack, rack_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Rack updated successfully.")
      |> redirect(to: rack_path(conn, :index))
    else
      cages = Repo.all(Rackit.Cage)
      render(conn, "edit.html", rack: rack, changeset: changeset, cages: cages)
    end
  end

  def delete(conn, %{"id" => id}) do
    rack = Repo.get(Rack, id)
    Repo.delete(rack)

    conn
    |> put_flash(:info, "Rack deleted successfully.")
    |> redirect(to: rack_path(conn, :index))
  end
end
