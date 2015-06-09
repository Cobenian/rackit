defmodule Rackit.Repo.Migrations.CreateCage do
  use Ecto.Migration

  def change do
    create table(:cages) do
      add :name, :string
      add :room_id, :integer

      timestamps
    end
    create index(:cages, [:room_id])

  end
end
