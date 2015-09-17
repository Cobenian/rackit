defmodule Rackit.Repo.Migrations.CreatePoc do
  use Ecto.Migration

  def change do
    create table(:pocs) do
      add :first, :string
      add :last, :string
      add :phone, :string
      add :email, :string
      add :pager, :string
      add :company_id, :integer

      timestamps
    end
    create index(:pocs, [:company_id])

  end
end
