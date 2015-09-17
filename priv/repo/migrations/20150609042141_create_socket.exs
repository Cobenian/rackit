defmodule Rackit.Repo.Migrations.CreateSocket do
  use Ecto.Migration

  def change do
    create table(:sockets) do
      add :position, :integer
      add :pdu_id, :integer

      timestamps
    end
    create index(:sockets, [:pdu_id])

  end
end
