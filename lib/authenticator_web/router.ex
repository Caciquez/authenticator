defmodule AuthenticatorWeb.Router do
  use AuthenticatorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AuthenticatorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthenticatorWeb do
    pipe_through :browser

    get "/", RedirectController, :redirect_authenticated

    live "/signup", SignUpLive, :index
    live "/signin", SignInLive, :index
    live "/token_confirmation", TokenConfirmationLive, :verify
    live "/users", UserLive.Index, :index
    live "/users/:id/edit", UserLive.Index, :edit

    live "/users/:id", UserLive.Show, :show
    live "/users/:id/show/edit", UserLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", AuthenticatorWeb do
  #   pipe_through :api
  # end
end
