defmodule Rackit.Repo.Migrations.CreateFloor do
  use Ecto.Migration

  def change do
    create table(:floors) do
      add :name, :string
      add :building_id, :integer

      timestamps
    end
    create index(:floors, [:building_id])

  end
end
