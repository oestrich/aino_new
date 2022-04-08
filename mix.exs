defmodule AinoNew.MixProject do
  use Mix.Project

  def project do
    [
      app: :aino_new,
      version: "0.3.1",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      package: [
        maintainers: ["Eric Oestrich"],
        licenses: ["MIT"],
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
