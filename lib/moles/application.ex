defmodule Moles.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Moles.Repo,
      # Start the Telemetry supervisor
      MolesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Moles.PubSub},
      # Presence server
      MolesWeb.Presence,
      # Start the Endpoint (http/https)
      MolesWeb.Endpoint
      # Start a worker by calling: Moles.Worker.start_link(arg)
      # {Moles.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Moles.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MolesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
