defmodule Rackit.PowerSupplyController do
  use Rackit.Web, :controller

  alias Rackit.PowerSupply

  plug :scrub_params, "power_supply" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    power_supplies = Repo.all(PowerSupply) |> Enum.map(fn(power_supply) ->
      power_supply |> Repo.preload(:device)
    end)
    render(conn, "index.html", power_supplies: power_supplies)
  end

  def new(conn, _params) do
    changeset = PowerSupply.changeset(%PowerSupply{})
    devices = Repo.all(Rackit.Device)
    render(conn, "new.html", changeset: changeset, devices: devices)
  end

  def create(conn, %{"power_supply" => power_supply_params}) do
    changeset = PowerSupply.changeset(%PowerSupply{}, power_supply_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "PowerSupply created successfully.")
      |> redirect(to: power_supply_path(conn, :index))
    else
      devices = Repo.all(Rackit.Device)
      render(conn, "new.html", changeset: changeset, devices: devices)
    end
  end

  def show(conn, %{"id" => id}) do
    power_supply = Repo.get(PowerSupply, id) |> Repo.preload(:device)
    render(conn, "show.html", power_supply: power_supply)
  end

  def edit(conn, %{"id" => id}) do
    power_supply = Repo.get(PowerSupply, id) |> Repo.preload(:device)
    changeset = PowerSupply.changeset(power_supply)
    devices = Repo.all(Rackit.Device)
    render(conn, "edit.html", power_supply: power_supply, changeset: changeset, devices: devices)
  end

  def update(conn, %{"id" => id, "power_supply" => power_supply_params}) do
    power_supply = Repo.get(PowerSupply, id) |> Repo.preload(:device)
    changeset = PowerSupply.changeset(power_supply, power_supply_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "PowerSupply updated successfully.")
      |> redirect(to: power_supply_path(conn, :index))
    else
      devices = Repo.all(Rackit.Device)
      render(conn, "edit.html", power_supply: power_supply, changeset: changeset, devices: devices)
    end
  end

  def delete(conn, %{"id" => id}) do
    power_supply = Repo.get(PowerSupply, id)
    Repo.delete(power_supply)

    conn
    |> put_flash(:info, "PowerSupply deleted successfully.")
    |> redirect(to: power_supply_path(conn, :index))
  end
end
