# path: $HOME/.bash_profile
#set a decent size
export HISTSIZE=100000
#ignore duplicate consecuetive lines
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#erase duplicates
export HISTCONTROL=erasedups
#append to the bash_history file on exit, rather than over-writing
shopt -s histappend 
shopt -s checkwinsize

stty erase 
