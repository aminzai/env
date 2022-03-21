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
else ifeq ($(OS), Ubuntu)
	# diff-so-fancy
	sudo add-apt-repository ppa:aos1/diff-so-fancy
	sudo apt-get update
	sudo apt-get install -y diff-so-fancy
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"

	sudo apt install -y exuberant-ctags
	sudo apt install -y tree
endif
else ifeq ($(UNAME),Darwin)
	brew install diff-so-fancy
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"
	brew install java
	sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
endif

hg: env
	ln -sf ${BASEDIR}/_hgrc ${HOME}/.hgrc

env:
	ln -sf ${BASEDIR} ${HOME}/.env
