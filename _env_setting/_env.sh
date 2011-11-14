
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

# enable color support of ls and also add handy aliases
# NOTE: MacOSX not support parameter '--color=auto'
if [ `uname` = "Darwin" ];
then
    alias ls='ls -G'
else
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
