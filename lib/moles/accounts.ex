defmodule Moles.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Moles.Repo

  alias Moles.Accounts.User

  @doc """
  Gets or creates a new user identified by token
  """
  def get_or_create_user!(token) do
    case Repo.get_by(User, token: token) do
      nil -> create_random_user!()
      user -> user
    end
  end

  def create_random_user!() do
    random_user_attrs() |> create_user()
  end

  @random_user_url "https://randomuser.me/api/?nat=us"

  def random_user_attrs() do
    random_user =
      @random_user_url
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Poison.decode!()
      |> Map.get("results")
      |> Enum.at(0)

    %{
      token: random_user["login"]["uuid"],
      first_name: random_user["name"]["first"],
      last_name: random_user["name"]["last"],
      username: random_user["login"]["username"],
      gravatar: random_user["picture"]["large"]
    }
  end

  def get_users_map(ids) do
    case length(ids) do
      0 ->
        []

      _ ->
        query = from u in User, where: u.id in ^ids, select: {u.id, u}
        query |> Repo.all() |> Enum.into(%{})
    end
  end

  def list_user do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
