defmodule Mix.Tasks.Aino.New do
  @moduledoc "Mix task to generate a new Aino application"

  use Mix.Task

  @version Mix.Project.config()[:version]
  @shortdoc "Generate a new Aino v#{@version} application"

  @templates [
    "config/config.exs",
    "mix.exs",
    "README.md"
  ]

  @files [
    "assets/package.json",
    "assets/postcss.config.js",
    "assets/tailwind.config.js",
    "assets/css/app.scss",
    "bin/server",
    "bin/setup",
    "priv/repo/migrations/.gitkeep",
    "priv/static/.gitkeep",
    "shell.nix",
    "test/test_helper.exs"
  ]

  @dot_templates [
    "env",
    "env.test"
  ]

  @dot_files [
    "envrc",
    "formatter.exs",
    "gitignore",
    "tool-versions"
  ]

  @app_templates [
    "application.ex",
    "config.ex",
    "repo.ex",
    "web/handler.ex",
    "web/layout.ex",
    "web/page.ex",
    "web/templates/layout/app.html.eex",
    "web/templates/pages/root.html.eex"
  ]

  @impl true
  def run([project_path]) do
    project_path = Path.expand(project_path)
    app = Path.basename(project_path)
    app_module = Macro.camelize(app)
    app_path = Path.join(project_path, "lib/#{app}")

    assigns = %{
      app: app,
      app_module: app_module
    }

    Mix.Generator.create_directory(project_path)

    Enum.each(@templates, fn file ->
      Mix.Generator.copy_template("templates/#{file}", Path.join(project_path, file), assigns)
    end)

    Enum.each(@files, fn file ->
      Mix.Generator.copy_file("templates/#{file}", Path.join(project_path, file))
    end)

    Enum.each(@dot_templates, fn file ->
      Mix.Generator.copy_template(
        "templates/#{file}",
        Path.join(project_path, ".#{file}"),
        assigns
      )
    end)

    Enum.each(@dot_files, fn file ->
      Mix.Generator.copy_file("templates/#{file}", Path.join(project_path, ".#{file}"))
    end)

    Enum.each(@app_templates, fn file ->
      Mix.Generator.copy_template("templates/lib/app/#{file}", Path.join(app_path, file), assigns)
    end)
  end
end
