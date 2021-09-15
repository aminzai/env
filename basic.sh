
#===========================================
# PATH
#===========================================
# Setting my PATH

#my base script
export PATH=$PATH:$HOME/bin:/sbin

#===========================================
# EXPORT
#===========================================
#SVN EDITOR
export SVN_EDITOR=vim

export EDITOR=vim

#===========================================
# ALIAS
#===========================================
alias ll='ls -al'
alias la='ls -A'
alias l='ls -aCF'
alias vi='vim'
alias g='gvim'
alias icdiff='icdiff --highlight'

# enable color support of ls and also add handy aliases
# NOTE: MacOSX not support parameter '--color=auto'
case `uname` in
    "Darwin")
        alias ls='ls -G'
        ;;
    "FreeBSD")
        alias ls='ls -G'
        ;;
	"Linux")
        alias ls='ls --color=auto'
	;;
    *)
        #eval "`dircolors -b`"

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
        ;;
esac
