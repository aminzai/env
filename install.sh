#!/bin/bash
TIMESTAMP=`date "+%Y%m%d%H%M%S"`

ENV=${HOME}/.env
ENV_SRC=${PWD}

ZSHRC=${HOME}/.zshrc
ZSHRC_SRC=${PWD}/_zshrc

BASHRC=${HOME}/.bashrc
BASHRC_SRC=${PWD}/_bashrc

TMUX_CONF=${HOME}/.tmux.conf
TMUX_CONF_SRC=${PWD}/_tmux.conf

SCREENRC=${HOME}/.screenrc
SCREENRC_SRC=${PWD}/_screenrc

GITCONFIG=${HOME}/.gitconfig
GITCONFIG_SRC=${PWD}/_gitconfig

HGRC=${HOME}/.hgrc
HGRC_SRC=${PWD}/_hgrc

RED="\033[0;31m"
LIGHT_BLUE="\033[1;34m"
NC="\033[0m"

echo -e "${LIGHT_BLUE}Start install env settings....$NC"

backup_file () {
	echo -e "${RED}${1} is already exist!${NC}"
	read -p "Would you like to backup ${1}? [y/n]" ANS
	if [ "$ANS" == "y" ]; then
		BAK=${1}-${TIMESTAMP}
		echo "Backup original ${1} to ${BAK}"
		mv ${1} ${BAK}
	else
		echo -e "${LIGHT_BLUE}Bye!${NC}"
		exit
	fi
}

file_check () {
	if [ -L ${1} ] || [ -f ${1} ] || [ -d ${1} ]; then
		backup_file ${1}
	fi
}

#for ITEM in ${ZSHRC} ${BASHRC} ${SCREENRC} ${TMUX_CONF} ${GITCONFIG} ${HGRC}; do
for ITEM in ZSHRC BASHRC SCREENRC TMUX_CONF GITCONFIG HGRC ENV; do

	TARGET=${!ITEM}
	SRC_NAME=${ITEM}_SRC
	SRC=${!SRC_NAME}

	if [ "${1}" != "-f" ]
	then
		file_check ${TARGET}
	fi

	ln -sf ${SRC} ${TARGET}
done

echo -e "${LIGHT_BLUE}Done!${NC}"
