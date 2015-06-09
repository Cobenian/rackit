defmodule Rackit.PortController do
  use Rackit.Web, :controller

  alias Rackit.Port

  plug :scrub_params, "port" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    ports = Repo.all(Port) |> Enum.map(fn(port) ->
      port |> Repo.preload(:pdu) |> Repo.preload(:device) |> Repo.preload(:transit)
    end)
    render(conn, "index.html", ports: ports)
  end

  def new(conn, _params) do
    changeset = Port.changeset(%Port{})
    pdus = Repo.all(Rackit.Pdu)
    devices = Repo.all(Rackit.Device)
    transits = Repo.all(Rackit.Transit)
    render(conn, "new.html", changeset: changeset, pdus: pdus, devices: devices, transits: transits)
  end

  def create(conn, %{"port" => port_params}) do
    changeset = Port.changeset(%Port{}, port_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Port created successfully.")
      |> redirect(to: port_path(conn, :index))
    else
      pdus = Repo.all(Rackit.Pdu)
      devices = Repo.all(Rackit.Device)
      transits = Repo.all(Rackit.Transit)
      render(conn, "new.html", changeset: changeset, pdus: pdus, devices: devices, transits: transits)
    end
  end

  def show(conn, %{"id" => id}) do
    port = Repo.get(Port, id) |> Repo.preload(:pdu) |> Repo.preload(:device) |> Repo.preload(:transit)
    render(conn, "show.html", port: port)
  end

  def edit(conn, %{"id" => id}) do
    port = Repo.get(Port, id) |> Repo.preload(:pdu) |> Repo.preload(:device) |> Repo.preload(:transit)
    changeset = Port.changeset(port)
    pdus = Repo.all(Rackit.Pdu)
    devices = Repo.all(Rackit.Device)
    transits = Repo.all(Rackit.Transit)
    render(conn, "edit.html", port: port, changeset: changeset, pdus: pdus, devices: devices, transits: transits)
  end

  def update(conn, %{"id" => id, "port" => port_params}) do
    port = Repo.get(Port, id) |> Repo.preload(:pdu) |> Repo.preload(:device) |> Repo.preload(:transit)
    changeset = Port.changeset(port, port_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Port updated successfully.")
      |> redirect(to: port_path(conn, :index))
    else
      pdus = Repo.all(Rackit.Pdu)
      devices = Repo.all(Rackit.Device)
      transits = Repo.all(Rackit.Transit)
      render(conn, "edit.html", port: port, changeset: changeset, pdus: pdus, devices: devices, transits: transits)
    end
  end

  def delete(conn, %{"id" => id}) do
    port = Repo.get(Port, id)
    Repo.delete(port)

    conn
    |> put_flash(:info, "Port deleted successfully.")
    |> redirect(to: port_path(conn, :index))
  end
end
