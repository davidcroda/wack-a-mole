defmodule Moles.Rounds.Mole do
  use Ecto.Schema
  import Ecto.Changeset
  alias Moles.Accounts.User

  schema "moles" do
    field :row, :integer
    field :col, :integer

    field :wacked, :boolean, default: false
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(mole, attrs \\ %{}) do
    mole
    |> cast(attrs, [:row, :col, :wacked])
    |> cast_assoc(:user)
    |> validate_required([:row, :col])
  end
end
