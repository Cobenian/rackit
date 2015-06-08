defmodule Rackit.Repo.Migrations.CreateBuilding do
  use Ecto.Migration

  def change do
    create table(:buildings) do
      add :street1, :string
      add :street2, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :zip, :string
      add :name, :string
      add :note, :string
      add :data_center_id, :integer

      timestamps
    end
    create index(:buildings, [:data_center_id])

  end
end
