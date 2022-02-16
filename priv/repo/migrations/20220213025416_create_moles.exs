defmodule Moles.Repo.Migrations.CreateMoles do
  use Ecto.Migration

  def change do
    create table(:moles) do
      add :row, :integer
      add :col, :integer

      add :wacked, :boolean, default: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:moles, [:user_id])
  end
end
