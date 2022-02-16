defmodule Moles.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :token, :uuid
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :gravatar, :string

      timestamps()
    end

    create unique_index(:users, :username)
  end
end
