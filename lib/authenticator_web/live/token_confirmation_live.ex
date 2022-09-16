defmodule AuthenticatorWeb.TokenConfirmationLive do
  use AuthenticatorWeb, :live_view

  alias Authenticator.Tokens.Store

  def render(assigns) do
    ~H"""
      <div>
        <h2>Code Confirmation</h2>
        <form
        phx-submit="validate">
        <div class="code-wrapper">
          <input
            type="text"
            name="code"
            value=""
            autofocus
            autocomplete="off" />
          <button type="submit">
            Verify
          </button>
        </div>
      </form>
      </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("validate", %{"code" => code}, socket) do
    case Store.one(%{token: code}) do
      {:ok, _token} ->
        {:noreply,
         socket
         |> put_flash(:info, "Logged in successfully")
         |> redirect(to: Routes.user_index_path(socket, :index))}

      {:error, reason} ->
        {:noreply, assign(socket, error: reason)}
    end
  end
end
