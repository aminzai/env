.PHONY: all zsh bash tmux screen git hg env help links check
OS=$(shell lsb_release -si)
VER=$(shell lsb_release -sr)
UNAME=$(shell uname -s)
BASEDIR=$(shell pwd)

all: bash zsh tmux screen git hg env

help:
	@echo "make all    Install all managed dotfile symlinks"
	@echo "make links  Show the Bash, Zsh, and env symlinks"
	@echo "make check  Validate shell configuration syntax"

links:
	@ls -l ${HOME}/.bashrc ${HOME}/.zshrc ${HOME}/.env

check:
	@bash -n ${BASEDIR}/_bashrc ${BASEDIR}/shell/base
	@zsh -n ${BASEDIR}/_zshrc ${BASEDIR}/shell/base

zsh: env
	ln -sf ${BASEDIR}/_zshrc ${HOME}/.zshrc

bash: env
	ln -sf ${BASEDIR}/_bashrc ${HOME}/.bashrc

tmux:
	ln -sf ${BASEDIR}/_tmux.conf ${HOME}/.tmux.conf

screen:
	ln -sf ${BASEDIR}/_screenrc ${HOME}/.screenrc

git:
	ln -sf ${BASEDIR}/_gitconfig ${HOME}/.gitconfig
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


hg: env
	ln -sf ${BASEDIR}/_hgrc ${HOME}/.hgrc

env:
	ln -sf ${BASEDIR} ${HOME}/.env
