#
# path: $HOME/.bashrc
#

export PATH=$HOME/bin/:$HOME/local/bin/:$PATH:$HOME/.gem/ruby/1.9.1/bin

if [ -f ~/.bash_colors ]; then
    source ~/.bash_colors
fi

if [ -f ~/.dir_colors ]; then
    eval `dircolors  ~/.dircolors/dircolors.ansi-light`
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#set a decent size
HISTSIZE=100000
#ignore duplicate consecuetive lines
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#erase duplicates
export HISTCONTROL=erasedups
#append to the bash_history file on exit, rather than over-writing
shopt -s histappend 
shopt -s checkwinsize

export PS1="\[$BICyan\]\[$Cyan\]\u\[$BCyan\]@\h \[$IWhite\]\W\[$Color_Off\] $ "
export EDITOR="vim"

stty erase 
