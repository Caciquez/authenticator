defmodule AuthenticatorWeb.RedirectController do
  use AuthenticatorWeb, :controller


  def redirect_authenticated(conn, _) do
    # if conn.assigns.current_user do
    #   #redirect if user is authenticated
    #   redirect(conn, to: Routes.sign_in_path(conn, :index))
    # else
      redirect(conn, to: Routes.sign_up_path(conn, :index))
    # end
  end
end
