defmodule Rackit.RoomController do
  use Rackit.Web, :controller

  alias Rackit.Room

  plug :scrub_params, "room" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    rooms = Repo.all(Room) |> Enum.map(fn(room) ->
      room |> Repo.preload(:floor)
    end)
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    floors = Repo.all(Rackit.Floor)
    render(conn, "new.html", changeset: changeset, floors: floors)
  end

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Room created successfully.")
      |> redirect(to: room_path(conn, :index))
    else
      floors = Repo.all(Rackit.Floor)
      render(conn, "new.html", changeset: changeset, floors: floors)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Repo.get(Room, id) |> Repo.preload(:floor)
    render(conn, "show.html", room: room)
  end

  def edit(conn, %{"id" => id}) do
    room = Repo.get(Room, id) |> Repo.preload(:floor)
    changeset = Room.changeset(room)
    floors = Repo.all(Rackit.Floor)
    render(conn, "edit.html", room: room, changeset: changeset, floors: floors)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Repo.get(Room, id) |> Repo.preload(:floor)
    changeset = Room.changeset(room, room_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Room updated successfully.")
      |> redirect(to: room_path(conn, :index))
    else
      floors = Repo.all(Rackit.Floor)
      render(conn, "edit.html", room: room, changeset: changeset, floors: floors)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Repo.get(Room, id)
    Repo.delete(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: room_path(conn, :index))
  end
end
