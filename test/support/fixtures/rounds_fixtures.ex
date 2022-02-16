defmodule Moles.RoundsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Moles.Rounds` context.
  """

  @doc """
  Generate a mole.
  """
  def mole_fixture(attrs \\ %{}) do
    {:ok, mole} =
      attrs
      |> Enum.into(%{

      })
      |> Moles.Rounds.create_mole()

    mole
  end
end
