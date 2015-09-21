defmodule Rackit.Router do
  use Rackit.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Rackit do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", PageController, :login
    post "/login", PageController, :authn
    get "/register", PageController, :register

    scope "/rackit" do
      get "/dashboard", PageController, :dashboard
      get "/data_centers", PageController, :data_centers
      get "/racks", PageController, :racks
      get "/devices", PageController, :devices
      get "/drives", PageController, :drives
      get "/powers", PageController, :powers
      get "/networks", PageController, :networks
      get "/reports", PageController, :reports
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rackit do
  #   pipe_through :api
  # end
end
