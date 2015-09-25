defmodule PerceiveMe.Router do
  use PerceiveMe.Web, :router

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

  scope "/", PerceiveMe do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/me", PersonController, :show_form
    post "/me", PersonController, :create

    get "/they", PersonController, :show_random
    get "/they/:person_url", PersonController, :show_them

    post "/they", PersonController, :perceive

  end

  # Other scopes may use custom stacks.
  # scope "/api", PerceiveMe do
  #   pipe_through :api
  # end
end
