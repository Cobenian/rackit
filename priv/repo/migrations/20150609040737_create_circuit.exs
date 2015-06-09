defmodule Rackit.Repo.Migrations.CreateCircuit do
  use Ecto.Migration

  def change do
    create table(:circuits) do
      add :name, :string
      add :amps, :integer
      add :cage_id, :integer

      timestamps
    end
    create index(:circuits, [:cage_id])

  end
end
