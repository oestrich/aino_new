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
    "shell.nix",
    "test/test_helper.exs"
  ]

  @folders [
    "priv/repo/migrations",
    "priv/static"
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
    template_path = Path.join(:code.priv_dir(:aino_new), "templates")

    project_path = Path.expand(project_path)
    app = Path.basename(project_path)
    app_module = Macro.camelize(app)

    template_app_path = Path.join(template_path, "lib/app")
    app_path = Path.join(project_path, "lib/#{app}")

    assigns = %{
      app: app,
      app_module: app_module
    }

    Mix.Generator.create_directory(project_path)

    Enum.each(@templates, fn file ->
      Mix.Generator.copy_template(Path.join(template_path, file), Path.join(project_path, file), assigns)
    end)

    Enum.each(@files, fn file ->
      Mix.Generator.copy_file(Path.join(template_path, file), Path.join(project_path, file))
    end)

    Enum.each(@folders, fn folder ->
      Mix.Generator.create_directory(Path.join(project_path, folder))
    end)

    Enum.each(@dot_templates, fn file ->
      Mix.Generator.copy_template(
        Path.join(template_path, file),
        Path.join(project_path, ".#{file}"),
        assigns
      )
    end)

    Enum.each(@dot_files, fn file ->
      Mix.Generator.copy_file(Path.join(template_path, file), Path.join(project_path, ".#{file}"))
    end)

    Enum.each(@app_templates, fn file ->
      Mix.Generator.copy_template(Path.join(template_app_path, file), Path.join(app_path, file), assigns)
    end)

    Mix.shell.info("""
    Your new #{IO.ANSI.blue()}Aino#{IO.ANSI.reset()} application was created!

    To finish installing, perform the following setup steps

        cd #{app}/
        mix deps.get
        (cd assets && yarn install && yarn build:css)
        mix ecto.create
        mix run --no-halt
    """)
  end
end
