defmodule AuthenticatorWeb.SignInLive do
  use AuthenticatorWeb, :live_view

  alias Authenticator.Accounts

  def render(assigns) do
    ~H"""
      <div>
        <h2>Sign In</h2>

        <.form
          let={f}
          for={@changeset}
          id="user-form"
          phx-change="validate"
          phx-submit="save">

          <%= label f, :email %>
          <%= text_input f, :email %>
          <%= error_tag f, :email %>

          <%= label f, :password %>
          <%= text_input f, :password %>
          <%= error_tag f, :password %>

          <div>
            <%= submit "Register", phx_disable_with: "Registering..." %>
          </div>
        </.form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :changeset, Accounts.get_registeration_changeset())}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    IO.inspect(socket.assigns)

    changeset =
      user_params
      |> Accounts.check_registration()
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> redirect(to: Routes.user_index_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
