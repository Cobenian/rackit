defmodule Rackit.TransitController do
  use Rackit.Web, :controller

  alias Rackit.Transit

  plug :scrub_params, "transit" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    transits = Repo.all(Transit) |> Enum.map(fn(transit) ->
      transit |> Repo.preload(:cage)
    end)
    render(conn, "index.html", transits: transits)
  end

  def new(conn, _params) do
    changeset = Transit.changeset(%Transit{})
    cages = Repo.all(Rackit.Cage)
    render(conn, "new.html", changeset: changeset, cages: cages)
  end

  def create(conn, %{"transit" => transit_params}) do
    changeset = Transit.changeset(%Transit{}, transit_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Transit created successfully.")
      |> redirect(to: transit_path(conn, :index))
    else
      cages = Repo.all(Rackit.Cage)
      render(conn, "new.html", changeset: changeset, cages: cages)
    end
  end

  def show(conn, %{"id" => id}) do
    transit = Repo.get(Transit, id) |> Repo.preload(:cage)
    render(conn, "show.html", transit: transit)
  end

  def edit(conn, %{"id" => id}) do
    transit = Repo.get(Transit, id) |> Repo.preload(:cage)
    changeset = Transit.changeset(transit)
    cages = Repo.all(Rackit.Cage)
    render(conn, "edit.html", transit: transit, changeset: changeset, cages: cages)
  end

  def update(conn, %{"id" => id, "transit" => transit_params}) do
    transit = Repo.get(Transit, id) |> Repo.preload(:cage)
    changeset = Transit.changeset(transit, transit_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Transit updated successfully.")
      |> redirect(to: transit_path(conn, :index))
    else
      cages = Repo.all(Rackit.Cage)
      render(conn, "edit.html", transit: transit, changeset: changeset, cages: cages)
    end
  end

  def delete(conn, %{"id" => id}) do
    transit = Repo.get(Transit, id)
    Repo.delete(transit)

    conn
    |> put_flash(:info, "Transit deleted successfully.")
    |> redirect(to: transit_path(conn, :index))
  end
end
