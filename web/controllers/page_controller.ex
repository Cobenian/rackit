defmodule Rackit.User do
  use Ecto.Model

  schema "user" do
  end
end

defmodule Rackit.PageController do
  use Rackit.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, params) do
    changeset = Ecto.Changeset.cast(%Rackit.User{}, :empty, ~w(), ~w())
    render conn, "login.html", changeset: changeset
  end

  def authn(conn, %{}) do
    redirect conn, to: "/rackit/dashboard"
  end

  def register(conn, _params) do
    render conn, "register.html"
  end

  def dashboard(conn, _params) do
    render conn, "dashboard.html"
  end

end
