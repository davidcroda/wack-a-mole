defmodule Moles.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :token, Ecto.UUID
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :gravatar, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:token, :username, :first_name, :last_name, :gravatar])
    |> validate_required([:token, :username, :first_name, :last_name, :gravatar])
    |> unique_constraint(:username)
  end
end
