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
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.st status
	git config --global alias.cp cherry-pick
	git config --global alias.st status
	git config --global alias.br "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
	git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
	git config --global alias.changelog "log --oneline --no-merges --pretty=format:'%s'"
	git config --global alias.brs "for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
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

ai-codex:
	npm install -g @openai/codex

ai-claude:
	npm install -g @anthropic-ai/claude-code
	npm install -g @musistudio/claude-code-router
	npx claude-code-templates@latest --hook=automation/agents-md-loader --yes
	npx claude-code-templates@latest --create-agent programming-languages/python-pro --yes
	npx claude-code-templates@latest --create-agent programming-languages/golang-pro --yes

ai: ai-codex ai-claude


hg: env
	ln -sf ${BASEDIR}/_hgrc ${HOME}/.hgrc

env:
	ln -sf ${BASEDIR} ${HOME}/.env
