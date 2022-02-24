.PHONY: all zsh bash tmux screen git hg env

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

hg: env
	ln -sf ${BASEDIR}/_hgrc ${HOME}/.hgrc

env:
	ln -sf ${BASEDIR} ${HOME}/.env
