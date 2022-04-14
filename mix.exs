defmodule AinoNew.MixProject do
  use Mix.Project

  def project do
    [
      app: :aino_new,
      version: "0.4.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      description: "Installer and new project generator for Aino",
      package: [
        maintainers: ["Eric Oestrich"],
        licenses: ["MIT"],
        links: %{
          "GitHub" => "https://github.com/oestrich/aino_new"
        }
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.28.3", only: [:dev], runtime: false}
    ]
  end
end
