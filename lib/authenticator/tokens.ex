defmodule Authenticator.Tokens do
  @salt "1Z73WxH/cDS96wsHXXI8QVAFOy5tg/APqIufGTO8nO2cTn/Mtp7zCnrx+0fSVY1/"
  @expiry 86400

  alias Phoenix.Token, as: PhoenixToken
  alias Authenticator.Tokens.{Token, Store}

  def sign(conn, data) do
    with token <- PhoenixToken.sign(conn, @salt, data),
         %Token{} = token <- build_token_struct(token, data, true),
         {:ok, _store_token} <- Store.write(token) do
      {:ok, token}
    end
  end

  def verify(conn, token, opts \\ []) do
    PhoenixToken.verify(conn, @salt, token, max_age: Keyword.get(opts, :max_age, @expiry))
  end

  def build_token_struct(token, user_id, valid? \\ true) do
    %Token{token: token, user_id: user_id, valid?: valid?}
  end

  def generate_2fa_token(data) do
    with confirmation_token <-
           :crypto.strong_rand_bytes(12)
           |> Base.encode32()
           |> :pot.hotp(1),
         %Token{} = token <- build_token_struct(confirmation_token, data, true),
         {:ok, _store_token} <- Store.write(token) do
      {:ok, token}
    end
  end
end

# %Token{login_token: 123, user_id: 123, valid?: true}
