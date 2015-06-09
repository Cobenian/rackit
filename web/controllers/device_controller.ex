defmodule Rackit.DeviceController do
  use Rackit.Web, :controller

  alias Rackit.Device

  plug :scrub_params, "device" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    devices = Repo.all(Device) |> Enum.map(fn(device) ->
      device |> Repo.preload(:device_type)
    end)
    render(conn, "index.html", devices: devices)
  end

  def new(conn, _params) do
    changeset = Device.changeset(%Device{})
    device_types = Repo.all(Rackit.DeviceType)
    render(conn, "new.html", changeset: changeset, device_types: device_types)
  end

  def create(conn, %{"device" => device_params}) do
    changeset = Device.changeset(%Device{}, device_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Device created successfully.")
      |> redirect(to: device_path(conn, :index))
    else
      device_types = Repo.all(Rackit.DeviceType)
      render(conn, "new.html", changeset: changeset, device_types: device_types)
    end
  end

  def show(conn, %{"id" => id}) do
    device = Repo.get(Device, id) |> Repo.preload(:device_type)
    render(conn, "show.html", device: device)
  end

  def edit(conn, %{"id" => id}) do
    device = Repo.get(Device, id) |> Repo.preload(:device_type)
    changeset = Device.changeset(device)
    device_types = Repo.all(Rackit.DeviceType)
    render(conn, "edit.html", device: device, changeset: changeset, device_types: device_types)
  end

  def update(conn, %{"id" => id, "device" => device_params}) do
    device = Repo.get(Device, id) |> Repo.preload(:device_type)
    changeset = Device.changeset(device, device_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Device updated successfully.")
      |> redirect(to: device_path(conn, :index))
    else
      device_types = Repo.all(Rackit.DeviceType)
      render(conn, "edit.html", device: device, changeset: changeset, device_types: device_types)
    end
  end

  def delete(conn, %{"id" => id}) do
    device = Repo.get(Device, id)
    Repo.delete(device)

    conn
    |> put_flash(:info, "Device deleted successfully.")
    |> redirect(to: device_path(conn, :index))
  end
end
