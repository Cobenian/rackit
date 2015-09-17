defmodule Rackit.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :device_type, :string
      add :data_center, :string
      add :power_in_use, :integer
      add :power_empty, :integer
      add :power_bad, :integer
      add :drives_in_use, :integer
      add :drives_empty, :integer
      add :drives_bad, :integer
      add :ports_in_use, :integer
      add :ports_empty, :integer
      add :ports_bad, :integer

      timestamps
    end

  end
end
