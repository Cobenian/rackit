defmodule Rackit.PocController do
  use Rackit.Web, :controller

  alias Rackit.Poc

  plug :scrub_params, "poc" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    pocs = Repo.all(Poc)
    render(conn, "index.html", pocs: pocs)
  end

  def new(conn, _params) do
    changeset = Poc.changeset(%Poc{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poc" => poc_params}) do
    changeset = Poc.changeset(%Poc{}, poc_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Poc created successfully.")
      |> redirect(to: poc_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poc = Repo.get(Poc, id)
    render(conn, "show.html", poc: poc)
  end

  def edit(conn, %{"id" => id}) do
    poc = Repo.get(Poc, id)
    changeset = Poc.changeset(poc)
    render(conn, "edit.html", poc: poc, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poc" => poc_params}) do
    poc = Repo.get(Poc, id)
    changeset = Poc.changeset(poc, poc_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Poc updated successfully.")
      |> redirect(to: poc_path(conn, :index))
    else
      render(conn, "edit.html", poc: poc, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poc = Repo.get(Poc, id)
    Repo.delete(poc)

    conn
    |> put_flash(:info, "Poc deleted successfully.")
    |> redirect(to: poc_path(conn, :index))
  end
end
