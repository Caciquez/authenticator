defmodule Authenticator.Accounts.Token do
  @salt "1Z73WxH/cDS96wsHXXI8QVAFOy5tg/APqIufGTO8nO2cTn/Mtp7zCnrx+0fSVY1/"
  @expiry 86400

  alias Phoenix.Token

  def sign(conn, data) do
    Token.sign(conn, @salt, data)
  end

  def verify(conn, token, opts \\ []) do
    Token.verify(conn, @salt, token, max_age: Keyword.get(opts, :max_age, @expiry))
  end
end
