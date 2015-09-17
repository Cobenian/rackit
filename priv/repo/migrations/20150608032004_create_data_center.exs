defmodule Rackit.Repo.Migrations.CreateDataCenter do
  use Ecto.Migration

  def change do
    create table(:data_centers) do
      add :name, :string
      add :company_id, :integer

      timestamps
    end
    create index(:data_centers, [:company_id])

  end
end
