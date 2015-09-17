defmodule Rackit.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :device_type_id, :integer

      timestamps
    end
    create index(:devices, [:device_type_id])

  end
end
