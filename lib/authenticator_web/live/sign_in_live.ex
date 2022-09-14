defmodule AuthenticatorWeb.SignInLive do
  use AuthenticatorWeb, :live_view

  alias Authenticator.Accounts
  alias Authenticator.Tokens

  def render(assigns) do
    ~H"""
      <div>
        <h2>Sign In</h2>

        <.form
          let={f}
          for={@changeset}
          id="user-form"
          phx-change="validate"
          phx-submit="signin">

          <%= label f, :email %>
          <%= text_input f, :email, phx_debounce: "blur" %>
          <%= error_tag f, :email %>

          <%= label f, :password %>
          <%= password_input f, :password, value: input_value(f, :password) %>
          <%= error_tag f, :password %>

          <div>
            <%= submit "Sign In", phx_disable_with: "Logging in..." %>
          </div>
        </.form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :changeset, Accounts.get_registeration_changeset())}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      user_params
      |> Accounts.check_registration()
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("signin", %{"user" => user_params}, socket) do
    case Accounts.authenticate_user(user_params) do
      {:ok, user} ->
        token = Tokens.sign(AuthenticatorWeb.Endpoint, user.id)

        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> redirect(to: Routes.user_index_path(socket, :index))}

      {:error, reason} ->
        {:noreply, assign(socket, error: reason)}
    end
  end
end
