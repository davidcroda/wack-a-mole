defmodule Moles.RoundsTest do
  use Moles.DataCase

  alias Moles.Rounds

  describe "moles" do
    alias Moles.Rounds.Mole

    import Moles.RoundsFixtures

    @invalid_attrs %{}

    test "list_moles/0 returns all moles" do
      mole = mole_fixture()
      assert Rounds.list_moles() == [mole]
    end

    test "get_mole!/1 returns the mole with given id" do
      mole = mole_fixture()
      assert Rounds.get_mole!(mole.id) == mole
    end

    test "create_mole/1 with valid data creates a mole" do
      valid_attrs = %{}

      assert {:ok, %Mole{} = mole} = Rounds.create_mole(valid_attrs)
    end

    test "create_mole/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rounds.create_mole(@invalid_attrs)
    end

    test "update_mole/2 with valid data updates the mole" do
      mole = mole_fixture()
      update_attrs = %{}

      assert {:ok, %Mole{} = mole} = Rounds.update_mole(mole, update_attrs)
    end

    test "update_mole/2 with invalid data returns error changeset" do
      mole = mole_fixture()
      assert {:error, %Ecto.Changeset{}} = Rounds.update_mole(mole, @invalid_attrs)
      assert mole == Rounds.get_mole!(mole.id)
    end

    test "delete_mole/1 deletes the mole" do
      mole = mole_fixture()
      assert {:ok, %Mole{}} = Rounds.delete_mole(mole)
      assert_raise Ecto.NoResultsError, fn -> Rounds.get_mole!(mole.id) end
    end

    test "change_mole/1 returns a mole changeset" do
      mole = mole_fixture()
      assert %Ecto.Changeset{} = Rounds.change_mole(mole)
    end
  end
end
