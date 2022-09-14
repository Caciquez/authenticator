defmodule Authenticator.Tokens.Store do
  use ActiveMemory.Store,
    table: Authenticator.Tokens.Token
end
