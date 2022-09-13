defmodule Authenticator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Authenticator.Repo,
      # Start the Telemetry supervisor
      AuthenticatorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Authenticator.PubSub},
      # Start the Endpoint (http/https)
      AuthenticatorWeb.Endpoint
      # Start a worker by calling: Authenticator.Worker.start_link(arg)
      # {Authenticator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Authenticator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuthenticatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
