defmodule Moles.AccountsTest do
  use Moles.DataCase

  alias Moles.Accounts

  describe "users" do
    alias Moles.Accounts.Users

    import Moles.AccountsFixtures

    @invalid_attrs %{gravatar: nil, name: nil, token: nil}

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Accounts.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Accounts.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{gravatar: "some gravatar", name: "some name", token: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Users{} = users} = Accounts.create_users(valid_attrs)
      assert users.gravatar == "some gravatar"
      assert users.name == "some name"
      assert users.token == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{gravatar: "some updated gravatar", name: "some updated name", token: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Users{} = users} = Accounts.update_users(users, update_attrs)
      assert users.gravatar == "some updated gravatar"
      assert users.name == "some updated name"
      assert users.token == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_users(users, @invalid_attrs)
      assert users == Accounts.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Accounts.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Accounts.change_users(users)
    end
  end
end
