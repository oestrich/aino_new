defmodule <%= @app_module %>.Web.Layout do
  alias Aino.Token
  alias Aino.Session

  require Aino.View

  Aino.View.compile([
    "lib/<%= @app %>/web/templates/layout/app.html.eex"
  ])

  def wrap(token) do
    case Token.response_header(token, "content-type") do
      ["text/html"] ->
        assigns = %{inner_content: {:safe, token.response_body}}
        render(token, "app.html", assigns)

      _ ->
        token
    end
  end
end
