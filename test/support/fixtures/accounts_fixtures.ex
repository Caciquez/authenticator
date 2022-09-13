defmodule Authenticator.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Authenticator.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "cool_email@gmail.com",
        login_token: "some_random_token",
        password: "some_password",
        password_confirmation: "some_password"
      })
      |> Authenticator.Accounts.create_user()

    user
  end
end
