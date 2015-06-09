defmodule Rackit.Repo.Migrations.CreateSlot do
  use Ecto.Migration

  def change do
    create table(:slots) do
      add :position, :integer
      add :rack_id, :integer

      timestamps
    end
    create index(:slots, [:rack_id])

  end
end
