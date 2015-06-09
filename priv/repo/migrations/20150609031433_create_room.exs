defmodule Rackit.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :floor_id, :integer

      timestamps
    end
    create index(:rooms, [:floor_id])

  end
end
