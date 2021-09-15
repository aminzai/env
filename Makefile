##################################################
# Aminzai's env install tool
# Date:Sun Oct 30 13:58:12 2011
##################################################
TIMESTAMP=`date "+%Y-%m-%d-%H:%M:%S"`
DIR_ENV_SETTING=${HOME}/.env_setting
DIR_ENV_SETTING_BAK=${HOME}/.env_setting_bak-${TIMESTAMP}

all:backup bashrc zshrc screenrc tmux
	@echo "--Install success!!--"

shell: bashrc zshrc
	@echo "--Setup shell env--"

bashrc:base_shell_env
	cat _bashrc > ${HOME}/.bashrc

zshrc:base_shell_env
	cat _zshrc > ${HOME}/.zshrc

base_shell_env:
	mkdir ${DIR_ENV_SETTING}
	cp -a _env_setting/* ${DIR_ENV_SETTING}/

screenrc:
	cat _screenrc > ${HOME}/.screenrc

tmux:
	cat _tmux.conf > ${HOME}/.tmux.conf

version_control_env:hgrc gitconfig
	@echo "-- Setup version control env --"
	
hgrc:
	cat _hgrc > ${HOME}/.hgrc

gitconfig:
	cat _gitconfig > ${HOME}/.gitconfig
	if [ -z ${HOME}/Dropbox/Environment/env/_github_gitconfig ]; then \
		cat ${HOME}/Dropbox/Environment/env/_github_gitconfig >> ${HOME}/.gitconfig;\
	fi

weechat:
	# Wait for fix

backup:
	@echo "--Backup to ${DIR_ENV_SETTING_BAK}....--"
	@echo ""
	mkdir ${DIR_ENV_SETTING_BAK}
	if [ -d ${DIR_ENV_SETTING} ];\
	then\
		cp -a \
			${HOME}/.zshrc \
			${HOME}/.bashrc \
			${DIR_ENV_SETTING} \
			${HOME}/.screenrc \
			${HOME}/.hgrc \
			${HOME}/.gitconfig \
			${DIR_ENV_SETTING_BAK}; \
	fi			

clean_backup:
	rm -rf ${HOME}/.env_setting_bak-*
