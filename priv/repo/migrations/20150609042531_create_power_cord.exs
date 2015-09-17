defmodule Rackit.Repo.Migrations.CreatePowerCord do
  use Ecto.Migration

  def change do
    create table(:power_cords) do
      add :serial, :string
      add :power_supply_id, :integer
      add :socket_id, :integer

      timestamps
    end
    create index(:power_cords, [:power_supply_id])
    create index(:power_cords, [:socket_id])

  end
end
