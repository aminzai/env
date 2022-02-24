.PHONY: all zsh bash tmux screen git hg env
OS=$(shell lsb_release -si)
VER=$(shell lsb_release -sr)
UNAME=$(shell uname -s)
BASEDIR=$(shell pwd)

all: bash zsh tmux screen git hg env

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
ifeq ($(UNAME),Linux)
ifeq ($(OS),ManjaroLinux)
	sudo pacman -Sy
	sudo pacman --noconfirm --needed -S diff-so-fancy
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"
endif
else ifeq ($(UNAME),Darwin)
	brew install diff-so-fancy
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"
endif

hg: env
	ln -sf ${BASEDIR}/_hgrc ${HOME}/.hgrc

env:
	ln -sf ${BASEDIR} ${HOME}/.env
