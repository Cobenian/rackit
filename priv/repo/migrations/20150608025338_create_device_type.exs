defmodule Rackit.Repo.Migrations.CreateDeviceType do
  use Ecto.Migration

  def change do
    create table(:device_types) do
      add :name, :string
      add :code, :string
      add :description, :string
      add :disabled, :boolean, default: false

      timestamps
    end

  end
end
