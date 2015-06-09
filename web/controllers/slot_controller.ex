defmodule Rackit.SlotController do
  use Rackit.Web, :controller

  alias Rackit.Slot

  plug :scrub_params, "slot" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    slots = Repo.all(Slot) |> Enum.map(fn(slot) ->
      slot |> Repo.preload(:rack)
    end)
    render(conn, "index.html", slots: slots)
  end

  def new(conn, _params) do
    changeset = Slot.changeset(%Slot{})
    racks = Repo.all(Rackit.Rack)
    render(conn, "new.html", changeset: changeset, racks: racks)
  end

  def create(conn, %{"slot" => slot_params}) do
    changeset = Slot.changeset(%Slot{}, slot_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Slot created successfully.")
      |> redirect(to: slot_path(conn, :index))
    else
      racks = Repo.all(Rackit.Rack)
      render(conn, "new.html", changeset: changeset, racks: racks)
    end
  end

  def show(conn, %{"id" => id}) do
    slot = Repo.get(Slot, id) |> Repo.preload(:rack)
    render(conn, "show.html", slot: slot)
  end

  def edit(conn, %{"id" => id}) do
    slot = Repo.get(Slot, id) |> Repo.preload(:rack)
    changeset = Slot.changeset(slot)
    racks = Repo.all(Rackit.Rack)
    render(conn, "edit.html", slot: slot, changeset: changeset, racks: racks)
  end

  def update(conn, %{"id" => id, "slot" => slot_params}) do
    slot = Repo.get(Slot, id) |> Repo.preload(:rack)
    changeset = Slot.changeset(slot, slot_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Slot updated successfully.")
      |> redirect(to: slot_path(conn, :index))
    else
      racks = Repo.all(Rackit.Rack)
      render(conn, "edit.html", slot: slot, changeset: changeset, racks: racks)
    end
  end

  def delete(conn, %{"id" => id}) do
    slot = Repo.get(Slot, id)
    Repo.delete(slot)

    conn
    |> put_flash(:info, "Slot deleted successfully.")
    |> redirect(to: slot_path(conn, :index))
  end
end
