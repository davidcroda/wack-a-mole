defmodule MolesWeb.Presence do
  use Phoenix.Presence,
    otp_app: :moles,
    pubsub_server: Moles.PubSub

  alias Moles.Accounts

  def fetch(_topic, presences) do
    users =
      presences
      |> Map.keys()
      |> Accounts.get_users_map()

    for {key, %{metas: metas}} <- presences, into: %{} do
      {key, %{metas: metas, user: users[String.to_integer(key)]}}
    end
  end

  # defp serialize_user(%Accounts.User{} = user) do
  #   %{
  #     first_name: user.first_name,
  #     last_name: user.last_name,
  #     username: user.username,
  #     gravatar: user.gravatar
  #   }
  # end
end
