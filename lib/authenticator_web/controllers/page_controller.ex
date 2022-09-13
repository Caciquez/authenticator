defmodule AuthenticatorWeb.PageController do
  use AuthenticatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
