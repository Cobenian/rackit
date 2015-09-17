defmodule Rackit.Repo.Migrations.CreateCable do
  use Ecto.Migration

  def change do
    create table(:cables) do
      add :serial, :string
      add :port_a_id, :integer
      add :port_b_id, :integer

      timestamps
    end
    create index(:cables, [:port_a_id])
    create index(:cables, [:port_b_id])

  end
end
