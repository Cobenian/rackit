defmodule Rackit.Router do
  use Rackit.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Rackit do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/device_types", DeviceTypeController
    resources "/companies", CompanyController
    resources "/pocs", PocController
    resources "/data_centers", DataCenterController
    resources "/buildings", BuildingController
    resources "/floors", FloorController
    resources "/rooms", RoomController
    resources "/cages", CageController
    resources "/racks", RackController
    resources "/slots", SlotController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rackit do
  #   pipe_through :api
  # end
end
