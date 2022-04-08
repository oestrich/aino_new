defmodule <%= @app_module %>.Web.Handler do
  @moduledoc false

  import Aino.Middleware.Routes, only: [routes: 1, get: 3]

  @behaviour Aino.Handler

  routes([
    get("/", &<%= @app_module %>.Web.Page.root/1, as: :root)
  ])

  @impl true
  def handle(token) do
    session_config = %Aino.Session.Cookie{
      key: "_<%= @app %>",
      salt: token.config.session_salt
    }

    middleware = [
      Aino.Middleware.common(),
      &Aino.Middleware.assets/1,
      &Aino.Middleware.Development.recompile/1,
      &Aino.Session.config(&1, session_config),
      &Aino.Session.decode/1,
      &Aino.Session.Flash.load/1,
      &Aino.Middleware.Routes.routes(&1, routes()),
      &Aino.Middleware.Routes.match_route/1,
      &Aino.Middleware.params/1,
      &Aino.Middleware.Routes.handle_route/1,
      &<%= @app_module %>.Web.Layout.wrap/1,
      &Aino.Session.encode/1,
      &Aino.Middleware.logging/1
    ]

    Aino.Token.reduce(token, middleware)
  end
end
