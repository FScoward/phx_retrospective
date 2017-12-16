defmodule PhxRetrospectiveWeb.Router do
  use PhxRetrospectiveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxRetrospectiveWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/signup", UserController
  end

  scope "/auth", PhxRetrospectiveWeb do
    pipe_through :browser

    get "/:provider", UserController, :index
    get "/:provider/callback", UserController, :callback
    delete "/logout", UserController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxRetrospectiveWeb do
  #   pipe_through :api
  # end
end
