.PHONY: all migrate zsh bash tmux git help links check
OS=$(shell lsb_release -si)
VER=$(shell lsb_release -sr)
UNAME=$(shell uname -s)
BASEDIR=$(shell pwd)
CONFIG_HOME=$(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)
INSTALL_LINK=${BASEDIR}/scripts/install-link
MIGRATE_CONFIG=${BASEDIR}/scripts/migrate-config

all: migrate zsh bash tmux git

help:
	@echo "make all    Migrate config and install managed symlinks"
	@echo "make migrate Move private config and remove the managed ~/.env link"
	@echo "make links  Show managed dotfile symlinks"
	@echo "make check  Validate shell configuration syntax"

links:
	@for path in \
		"${HOME}/.bashrc" "${HOME}/.zshrc" "${HOME}/.tmux.conf" \
		"${HOME}/.gitconfig"; do \
		if [ -e "$$path" ] || [ -L "$$path" ]; then ls -ld "$$path"; else echo "missing: $$path"; fi; \
	done

check:
	@bash -n "${BASEDIR}/_bashrc" "${BASEDIR}/shell/base"
	@zsh -n "${BASEDIR}/_zshrc" "${BASEDIR}/shell/base"
	@if grep -R -n -E '\$$\{?HOME\}?/\.env|~/\.env' \
		"${BASEDIR}/_bashrc" "${BASEDIR}/_zshrc" \
		"${BASEDIR}/_gitconfig" "${BASEDIR}/shell"; then \
		echo "error: found a legacy ~/.env dependency" >&2; exit 1; \
	fi

migrate:
	@"${MIGRATE_CONFIG}" "${BASEDIR}" "${CONFIG_HOME}"

zsh:
	@"${INSTALL_LINK}" "${BASEDIR}/_zshrc" "${HOME}/.zshrc"

bash:
	@"${INSTALL_LINK}" "${BASEDIR}/_bashrc" "${HOME}/.bashrc"

tmux:
	@"${INSTALL_LINK}" "${BASEDIR}/_tmux.conf" "${HOME}/.tmux.conf"

git:
	@"${INSTALL_LINK}" "${BASEDIR}/_gitconfig" "${HOME}/.gitconfig"
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
		git config --global alias.cp cherry-pick
		git config --global alias.br "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
	git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
	git config --global alias.changelog "log --oneline --no-merges --pretty=format:'%s'"
	git config --global alias.brs "for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
ifeq ($(UNAME),Linux)
ifeq ($(OS),ManjaroLinux)
	sudo pacman -Sy
else ifeq ($(OS), Ubuntu)
	sudo apt-get update

	sudo apt install -y exuberant-ctags
	sudo apt install -y tree
endif
else ifeq ($(UNAME),Darwin)
	brew install java
	sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
endif

ai-codex:
	curl -fsSL https://chatgpt.com/codex/install.sh | sh

ai-claude:
	curl -fsSL https://claude.ai/install.sh | bash

ai: ai-codex ai-claude
