defmodule Authenticator.Repo do
  use Ecto.Repo,
    otp_app: :authenticator,
    adapter: Ecto.Adapters.Postgres
end
