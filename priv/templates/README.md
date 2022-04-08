# <%= @app_module %>

## Setup

PostgreSQL is required and should be setup via your package manager or [Postgres.app](https://postgresapp.com/).

### Via Nix

Install [the nix package manager](https://nixos.org/download.html#nix-install-macos) by following their multi-user installer. Once nix is installed, setup [direnv](https://direnv.net/) by hooking into your shell.

```bash
nix-env -f '<nixpkgs>' -iA direnv
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
```

Once direnv is installed and your shell is restarted, clone the project and `cd` into it. You should see direnv warn about an untrusted `.envrc` file. Allow the file and finish installing dependencies and setting up the application.

```bash
direnv allow

setup # bin/setup
server # bin/server
```

You can load the application by going to [http://localhost:4000/](http://localhost:4000).

### Via asdf

Install [asdf-vm](https://asdf-vm.com/). Once installed you can run setup.

```bash
bin/setup
bin/server
```

You can load the application by going to [http://localhost:4000/](http://localhost:4000).
