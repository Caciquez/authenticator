defmodule AuthenticatorWeb.UserLive.Index do
  use AuthenticatorWeb, :live_view

  alias Authenticator.Tokens.Store

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tokens, list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :page_title, "Listing Tokens")
  end

  @impl true
  def handle_event("delete", %{"id" => uuid}, socket) do
    with {:ok, token} <- Store.one(%{uuid: uuid}),
         :ok <- Store.delete(token) do
      {:noreply, assign(socket, :users, list_users())}
    end
  end

  defp list_users do
    Store.all()
  end
end
