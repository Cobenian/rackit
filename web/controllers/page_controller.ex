defmodule Rackit.PageController do
  use Rackit.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
