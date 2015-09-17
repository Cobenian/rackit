defmodule Rackit.CompanyController do
  use Rackit.Web, :controller

  alias Rackit.Company

  plug :scrub_params, "company" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    companies = Repo.all(Company)
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Company.changeset(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    changeset = Company.changeset(%Company{}, company_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Company created successfully.")
      |> redirect(to: company_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Repo.get(Company, id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Repo.get(Company, id)
    changeset = Company.changeset(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Repo.get(Company, id)
    changeset = Company.changeset(company, company_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Company updated successfully.")
      |> redirect(to: company_path(conn, :index))
    else
      render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Repo.get(Company, id)
    Repo.delete(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: company_path(conn, :index))
  end
end
