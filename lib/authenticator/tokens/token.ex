defmodule Authenticator.Tokens.Token do
  use ActiveMemory.Table,
    options: [index: [:user_id]]

  attributes auto_generate_uuid: true do
    field(:token)
    field(:user_id)
    field(:valid?)
  end
end
