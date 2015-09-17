defmodule Rackit.DataCenterController do
  use Rackit.Web, :controller

  alias Rackit.DataCenter

  plug :scrub_params, "data_center" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    data_centers = Repo.all(DataCenter) |> Enum.map(fn(dc) ->
      dc |> Repo.preload(:company)
    end)
    render(conn, "index.html", data_centers: data_centers)
  end

  def new(conn, _params) do
    changeset = DataCenter.changeset(%DataCenter{})
    companies = Repo.all(Rackit.Company)
    render(conn, "new.html", changeset: changeset, companies: companies)
  end

  def create(conn, %{"data_center" => data_center_params}) do
    changeset = DataCenter.changeset(%DataCenter{}, data_center_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "DataCenter created successfully.")
      |> redirect(to: data_center_path(conn, :index))
    else
      companies = Repo.all(Rackit.Company)
      render(conn, "new.html", changeset: changeset, companies: companies)
    end
  end

  def show(conn, %{"id" => id}) do
    data_center = Repo.get(DataCenter, id) |> Repo.preload(:company)
    render(conn, "show.html", data_center: data_center)
  end

  def edit(conn, %{"id" => id}) do
    data_center = Repo.get(DataCenter, id) |> Repo.preload(:company)
    changeset = DataCenter.changeset(data_center)
    companies = Repo.all(Rackit.Company)
    render(conn, "edit.html", data_center: data_center, changeset: changeset, companies: companies)
  end

  def update(conn, %{"id" => id, "data_center" => data_center_params}) do
    data_center = Repo.get(DataCenter, id) |> Repo.preload(:company)
    changeset = DataCenter.changeset(data_center, data_center_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "DataCenter updated successfully.")
      |> redirect(to: data_center_path(conn, :index))
    else
      companies = Repo.all(Rackit.Company)
      render(conn, "edit.html", data_center: data_center, changeset: changeset, companies: companies)
    end
  end

  def delete(conn, %{"id" => id}) do
    data_center = Repo.get(DataCenter, id)
    Repo.delete(data_center)

    conn
    |> put_flash(:info, "DataCenter deleted successfully.")
    |> redirect(to: data_center_path(conn, :index))
  end
end
