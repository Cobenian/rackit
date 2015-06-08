defmodule Rackit.DeviceTypeController do
  use Rackit.Web, :controller

  alias Rackit.DeviceType

  plug :scrub_params, "device_type" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    device_types = Repo.all(DeviceType)
    render(conn, "index.html", device_types: device_types)
  end

  def new(conn, _params) do
    changeset = DeviceType.changeset(%DeviceType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"device_type" => device_type_params}) do
    changeset = DeviceType.changeset(%DeviceType{}, device_type_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "DeviceType created successfully.")
      |> redirect(to: device_type_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    device_type = Repo.get(DeviceType, id)
    render(conn, "show.html", device_type: device_type)
  end

  def edit(conn, %{"id" => id}) do
    device_type = Repo.get(DeviceType, id)
    changeset = DeviceType.changeset(device_type)
    render(conn, "edit.html", device_type: device_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "device_type" => device_type_params}) do
    device_type = Repo.get(DeviceType, id)
    changeset = DeviceType.changeset(device_type, device_type_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "DeviceType updated successfully.")
      |> redirect(to: device_type_path(conn, :index))
    else
      render(conn, "edit.html", device_type: device_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    device_type = Repo.get(DeviceType, id)
    Repo.delete(device_type)

    conn
    |> put_flash(:info, "DeviceType deleted successfully.")
    |> redirect(to: device_type_path(conn, :index))
  end
end
