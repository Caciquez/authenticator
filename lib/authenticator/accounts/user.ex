defmodule Authenticator.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    field :login_token, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_confirmation(:password)
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:email)
  end
end
