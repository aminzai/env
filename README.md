# Shell environment

This repository is the source of truth for the managed dotfiles. `make` creates
targeted symlinks from the home and config directories back to this repository:

- `~/.bashrc` → `_bashrc`
- `~/.zshrc` → `_zshrc`
- `~/.gitconfig` → `_gitconfig`

The repository itself is deliberately not linked to `~/.env`. That path is
commonly used for dotenv data and remains available as a normal file or
directory. Bash and Zsh resolve the repository from their startup-file
symlinks, so the checkout can live anywhere.

## Layout

- `shell/base` — settings shared by Bash and Zsh: PATH, aliases, fnm, SSH agent.
- `_bashrc` — Bash-only prompt and startup settings.
- `_zshrc` — Zsh-only completion, prompt, and interactive settings.
- `${XDG_CONFIG_HOME:-~/.config}/env/private.sh` — optional machine-local shell
  credentials and overrides. Start from `shell/private.example.sh`.
- `~/.config/git/config.private` — optional machine-local Git configuration.

## Commands

```sh
make all      # migrate local config and install all managed symlinks
make migrate  # migrate private files and remove the old managed ~/.env link
make links    # show current managed symlink targets
make check    # validate syntax and reject legacy ~/.env dependencies
```

The migration is safe to repeat. It removes `~/.env` only when the link points
to this checkout. An unrelated file, directory, or link is left untouched. A
private file is moved only after its new copy has been verified; if both paths
exist with different contents, migration stops and preserves both files.

## Credentials

Do not commit tokens or passwords to this repository. Store new secrets in the
private config paths above, set their mode to `600`, and rotate credentials that
were previously stored in tracked files.
