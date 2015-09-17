defmodule Rackit.Repo.Migrations.CreateRack do
  use Ecto.Migration

  def change do
    create table(:racks) do
      add :name, :string
      add :slot_count, :integer
      add :cage_id, :integer

      timestamps
    end
    create index(:racks, [:cage_id])

  end
end
