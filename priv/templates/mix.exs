defmodule <%= @app_module %>.MixProject do
  use Mix.Project

  def project() do
    [
      app: :<%= @app %>,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application() do
    [
      extra_applications: [:logger],
      mod: {<%= @app_module %>.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:aino, "~> 0.4"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, "~> 0.16"},
      {:vapor, "~> 0.10.0"}
    ]
  end

  defp aliases() do
    [
      "ecto.reset": ["ecto.create", "ecto.migrate"],
      "ecto.setup": ["ecto.reset", "run priv/repo/seeds.exs"],
      "ecto.migrate.reset": ["ecto.drop", "ecto.create", "ecto.migrate"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
