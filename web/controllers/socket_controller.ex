defmodule Rackit.SocketController do
  use Rackit.Web, :controller

  alias Rackit.Socket

  plug :scrub_params, "socket" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    sockets = Repo.all(Socket) |> Enum.map(fn(socket) ->
      socket |> Repo.preload(:pdu)
    end)
    render(conn, "index.html", sockets: sockets)
  end

  def new(conn, _params) do
    changeset = Socket.changeset(%Socket{})
    pdus = Repo.all(Rackit.Pdu)
    render(conn, "new.html", changeset: changeset, pdus: pdus)
  end

  def create(conn, %{"socket" => socket_params}) do
    changeset = Socket.changeset(%Socket{}, socket_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Socket created successfully.")
      |> redirect(to: socket_path(conn, :index))
    else
      pdus = Repo.all(Rackit.Pdu)
      render(conn, "new.html", changeset: changeset, pdus: pdus)
    end
  end

  def show(conn, %{"id" => id}) do
    socket = Repo.get(Socket, id) |> Repo.preload(:pdu)
    render(conn, "show.html", socket: socket)
  end

  def edit(conn, %{"id" => id}) do
    socket = Repo.get(Socket, id) |> Repo.preload(:pdu)
    changeset = Socket.changeset(socket)
    pdus = Repo.all(Rackit.Pdu)
    render(conn, "edit.html", socket: socket, changeset: changeset, pdus: pdus)
  end

  def update(conn, %{"id" => id, "socket" => socket_params}) do
    socket = Repo.get(Socket, id) |> Repo.preload(:pdu)
    changeset = Socket.changeset(socket, socket_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Socket updated successfully.")
      |> redirect(to: socket_path(conn, :index))
    else
      pdus = Repo.all(Rackit.Pdu)
      render(conn, "edit.html", socket: socket, changeset: changeset, pdus: pdus)
    end
  end

  def delete(conn, %{"id" => id}) do
    socket = Repo.get(Socket, id)
    Repo.delete(socket)

    conn
    |> put_flash(:info, "Socket deleted successfully.")
    |> redirect(to: socket_path(conn, :index))
  end
end
