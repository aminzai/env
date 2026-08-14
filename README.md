# Shell environment

This repository is the source of truth for the managed dotfiles. `make` creates
symlinks from the home directory back to this repository:

- `~/.bashrc` → `_bashrc`
- `~/.zshrc` → `_zshrc`
- `~/.env` → this repository

## Layout

- `shell/base` — settings shared by Bash and Zsh: PATH, aliases, fnm, SSH agent.
- `_bashrc` — Bash-only prompt and startup settings.
- `_zshrc` — Zsh-only completion, prompt, and interactive settings.
- `shell/private.sh` — optional machine-local credentials and overrides; ignored
  by Git. Start from `shell/private.example.sh`.

## Commands

```sh
make all    # install all managed symlinks
make links  # show current symlink targets
make check  # validate Bash and Zsh syntax
```

## Credentials

Do not commit tokens or passwords to this repository. Store new secrets in
`shell/private.sh`, set its mode to `600`, and rotate credentials that were
previously stored in tracked files.
