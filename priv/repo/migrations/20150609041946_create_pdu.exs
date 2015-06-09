defmodule Rackit.Repo.Migrations.CreatePdu do
  use Ecto.Migration

  def change do
    create table(:pdus) do
      add :name, :string
      add :socket_count, :integer
      add :circuit_id, :integer

      timestamps
    end
    create index(:pdus, [:circuit_id])

  end
end
