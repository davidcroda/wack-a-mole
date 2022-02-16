defmodule MolesWeb.Plugs.Auth do
  import Plug.Conn

  alias Moles.Accounts

  require Logger

  def init(params), do: params

  def call(conn, _params) do
    user =
      case get_session(conn, :user_id) do
        nil ->
          Accounts.create_random_user!()

        id ->
          case Accounts.get_user(id) do
            nil -> Accounts.create_random_user!()
            user -> user
          end
      end

    conn = put_session(conn, :user_id, user.id)

    assign(conn, :user, user)
  end
end
