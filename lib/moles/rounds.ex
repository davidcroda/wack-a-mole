defmodule Moles.Rounds do
  @moduledoc """
  The Rounds context.
  """

  import Ecto.Query, warn: false

  require Logger

  alias Moles.Repo
  alias Moles.Rounds.Mole

  def mole_query() do
    Mole
    |> where([m], m.wacked == false)
  end

  @doc """
  Returns the list of moles.

  ## Examples

      iex> list_moles()
      [%Mole{}, ...]

  """
  def list_moles do
    mole_query()
    |> Repo.all()
  end

  def count_moles do
    mole_query()
    |> select([m], count(m.id))
    |> Repo.one()
  end

  def count_user_moles(user_id) do
    Mole
    |> select([m], count(m.id))
    |> where([m], m.user_id == ^user_id)
    |> Repo.one()
  end

  def wack_mole(row, col, user) do
    mole_query()
    |> where([m], m.row == ^row and m.col == ^col)
    |> select([m], m.id)
    |> Repo.update_all(set: [wacked: true, user_id: user.id])
  end

  @doc """
  Gets a single mole.

  Raises `Ecto.NoResultsError` if the Mole does not exist.

  ## Examples

      iex> get_mole!(123)
      %Mole{}

      iex> get_mole!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mole!(id), do: Repo.get!(Mole, id)

  @doc """
  Creates a mole.

  ## Examples

      iex> create_mole(%{field: value})
      {:ok, %Mole{}}

      iex> create_mole(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mole(attrs \\ %{}) do
    %Mole{}
    |> Mole.changeset(attrs)
    |> Repo.insert()
  end

  @spec create_random_mole :: any
  def create_random_mole() do
    %Mole{}
    |> Mole.changeset(%{
      "row" => Enum.random(0..4),
      "col" => Enum.random(0..4)
    })
    |> Repo.insert!()
  end

  @doc """
  Updates a mole.

  ## Examples

      iex> update_mole(mole, %{field: new_value})
      {:ok, %Mole{}}

      iex> update_mole(mole, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mole(%Mole{} = mole, attrs) do
    mole
    |> Mole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mole.

  ## Examples

      iex> delete_mole(mole)
      {:ok, %Mole{}}

      iex> delete_mole(mole)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mole(%Mole{} = mole) do
    Repo.delete(mole)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mole changes.

  ## Examples

      iex> change_mole(mole)
      %Ecto.Changeset{data: %Mole{}}

  """
  def change_mole(%Mole{} = mole, attrs \\ %{}) do
    Mole.changeset(mole, attrs)
  end
end
