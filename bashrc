#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_colors ]; then
    source ~/.bash_colors
fi

if [ -f ~/.dir_colors ]; then
    eval `dircolors .dir_colors`
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export LC_ALL="C"
export PS1="\[$BICyan\][ \[$Cyan\]\u@\h \[$IWhite\]\W \[$BICyan\]]\[$Color_Off\] "

alias ls='ls --color=auto'

#set a decent size
HISTSIZE=100000
#ignore duplicate consecuetive lines
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#erase duplicates
export HISTCONTROL=erasedups
#append to the bash_history file on exit, rather than over-writing
shopt -s histappend 
