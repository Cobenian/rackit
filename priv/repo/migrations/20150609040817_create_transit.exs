defmodule Rackit.Repo.Migrations.CreateTransit do
  use Ecto.Migration

  def change do
    create table(:transits) do
      add :name, :string
      add :cage_id, :integer

      timestamps
    end
    create index(:transits, [:cage_id])

  end
end
