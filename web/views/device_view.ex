defmodule Rackit.DeviceView do
  use Rackit.Web, :view

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, Rackit.DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, Rackit.DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{id: device.id,
      name: device.name,
      device_type: device.device_type,
      data_center: device.data_center,
      power_in_use: device.power_in_use,
      power_empty: device.power_empty,
      power_bad: device.power_bad,
      drives_in_use: device.drives_in_use,
      drives_empty: device.drives_empty,
      drives_bad: device.drives_bad,
      ports_in_use: device.ports_in_use,
      ports_empty: device.ports_empty,
      ports_bad: device.ports_bad}
  end
end
