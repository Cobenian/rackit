defmodule Rackit.Repo.Migrations.CreatePowerSupply do
  use Ecto.Migration

  def change do
    create table(:power_supplies) do
      add :name, :string
      add :device_id, :integer

      timestamps
    end
    create index(:power_supplies, [:device_id])

  end
end
