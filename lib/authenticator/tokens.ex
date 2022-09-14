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
    %Token{login_token: token, user_id: user_id, valid?: valid?}
  end
end

# %Token{login_token: 123, user_id: 123, valid?: true}
