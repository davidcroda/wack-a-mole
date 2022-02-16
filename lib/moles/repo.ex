defmodule Moles.Repo do
  use Ecto.Repo,
    otp_app: :moles,
    adapter: Ecto.Adapters.Postgres
end
