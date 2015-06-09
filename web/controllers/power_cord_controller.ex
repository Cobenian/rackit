defmodule Rackit.PowerCordController do
  use Rackit.Web, :controller

  alias Rackit.PowerCord

  plug :scrub_params, "power_cord" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    power_cords = Repo.all(PowerCord) |> Enum.map(fn(cord) ->
      cord |> Repo.preload(:socket) |> Repo.preload(:power_supply)
    end)
    render(conn, "index.html", power_cords: power_cords)
  end

  def new(conn, _params) do
    changeset = PowerCord.changeset(%PowerCord{})
    sockets = Repo.all(Rackit.Socket)
    power_supplies = Repo.all(Rackit.PowerSupply)
    render(conn, "new.html", changeset: changeset, sockets: sockets, power_supplies: power_supplies)
  end

  def create(conn, %{"power_cord" => power_cord_params}) do
    changeset = PowerCord.changeset(%PowerCord{}, power_cord_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "PowerCord created successfully.")
      |> redirect(to: power_cord_path(conn, :index))
    else
      sockets = Repo.all(Rackit.Socket)
      power_supplies = Repo.all(Rackit.PowerSupply)
      render(conn, "new.html", changeset: changeset, sockets: sockets, power_supplies: power_supplies)
    end
  end

  def show(conn, %{"id" => id}) do
    power_cord = Repo.get(PowerCord, id) |> Repo.preload(:socket) |> Repo.preload(:power_supply)
    render(conn, "show.html", power_cord: power_cord)
  end

  def edit(conn, %{"id" => id}) do
    power_cord = Repo.get(PowerCord, id) |> Repo.preload(:socket) |> Repo.preload(:power_supply)
    changeset = PowerCord.changeset(power_cord)
    sockets = Repo.all(Rackit.Socket)
    power_supplies = Repo.all(Rackit.PowerSupply)
    render(conn, "edit.html", power_cord: power_cord, changeset: changeset, sockets: sockets, power_supplies: power_supplies)
  end

  def update(conn, %{"id" => id, "power_cord" => power_cord_params}) do
    power_cord = Repo.get(PowerCord, id) |> Repo.preload(:socket) |> Repo.preload(:power_supply)
    changeset = PowerCord.changeset(power_cord, power_cord_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "PowerCord updated successfully.")
      |> redirect(to: power_cord_path(conn, :index))
    else
      sockets = Repo.all(Rackit.Socket)
      power_supplies = Repo.all(Rackit.PowerSupply)
      render(conn, "edit.html", power_cord: power_cord, changeset: changeset, sockets: sockets, power_supplies: power_supplies)
    end
  end

  def delete(conn, %{"id" => id}) do
    power_cord = Repo.get(PowerCord, id)
    Repo.delete(power_cord)

    conn
    |> put_flash(:info, "PowerCord deleted successfully.")
    |> redirect(to: power_cord_path(conn, :index))
  end
end
