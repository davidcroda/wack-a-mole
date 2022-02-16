defmodule MolesWeb.MoleLive.Index do
  use MolesWeb, :live_view

  require Logger

  alias Moles.Accounts
  alias Moles.Rounds
  alias MolesWeb.Presence


  @topic "moles:lobby"

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    if connected?(socket) do
      Process.send_after(self(), :maybe_gen_mole, Enum.random(5..10) * 1000)
    end

    MolesWeb.Endpoint.subscribe(@topic)
    Presence.track(self(), @topic, user_id, %{})

    users =
      Presence.list(@topic)
      |> Enum.map(fn {_user_id, data} ->
        data[:user]
      end)

    socket =
      assign(socket,
        user: Accounts.get_user!(user_id),
        moles: Rounds.list_moles(),
        count: Rounds.count_user_moles(user_id),
        users: users
      )

    {:ok, socket}
  end

  @impl true
  def handle_info(:maybe_gen_mole, socket) do
    Process.send_after(self(), :maybe_gen_mole, Enum.random(5..10) * 1000)

    case Rounds.count_moles() < 5 do
      true ->
        mole = Rounds.create_random_mole()
        MolesWeb.Endpoint.broadcast_from!(self(), @topic, "mole_added", %{mole: mole})
        {:noreply, assign(socket, :moles, Rounds.list_moles())}

      false ->
        {:noreply, socket}
    end
  end

  def handle_info(%{event: "mole_added", payload: %{mole: mole}}, socket) do
    {:noreply, assign(socket, :moles, socket.assigns[:moles] ++ [mole])}
  end

  def handle_info(%{event: "mole_wacked", payload: %{moles: moles}}, socket) do
    moles =
      socket.assigns[:moles]
      |> Enum.filter(&(&1.id not in moles))

    {:noreply, assign(socket, :moles, moles)}
  end

  def handle_info(%{event: "presence_diff"}, socket) do
    users =
      Presence.list(@topic)
      |> Enum.map(fn {_user_id, data} ->
        data[:user]
      end)

    {:noreply, assign(socket, users: users)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Moles")
    |> assign(:moles, Rounds.list_moles())
  end

  defp check_mole(moles, row, col) do
    match =
      Enum.any?(moles, fn mole ->
        mole.row == row and mole.col == col
      end)

    case match do
      true -> "🐗"
      false -> ""
    end
  end

  @impl true
  def handle_event("wack_mole", %{"row" => row, "col" => col}, socket) do
    case Rounds.wack_mole(row, col, socket.assigns[:user]) do
      false ->
        {:noreply, socket}

      {_, moles} ->
        MolesWeb.Endpoint.broadcast!(@topic, "mole_wacked", %{moles: moles})
        {:noreply, assign(socket, :count, socket.assigns[:count] + length(moles))}
    end
  end
end
