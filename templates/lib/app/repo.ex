defmodule <%= @app_module %>.Repo do
  use Ecto.Repo,
    otp_app: :<%= @app %>,
    adapter: Ecto.Adapters.Postgres

  alias <%= @app_module %>.Config

  def init(_type, config) do
    vapor_config = Vapor.load!(Config)

    config =
      Keyword.merge(config,
        url: vapor_config.database.database_url,
        pool_size: vapor_config.database.pool_size
      )

    {:ok, config}
  end
end
