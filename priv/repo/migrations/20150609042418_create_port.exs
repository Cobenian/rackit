defmodule Rackit.Repo.Migrations.CreatePort do
  use Ecto.Migration

  def change do
    create table(:ports) do
      add :name, :string
      add :transit_id, :integer
      add :device_id, :integer
      add :pdu_id, :integer

      timestamps
    end
    create index(:ports, [:transit_id])
    create index(:ports, [:device_id])
    create index(:ports, [:pdu_id])

  end
end
