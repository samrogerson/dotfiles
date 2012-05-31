#
# path: $HOME/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_colors ]; then
    source ~/.bash_colors
fi

if [ -f ~/.dir_colors ]; then
    eval `dircolors  ~/.dir_colors`
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

export PATH=$PATH:$HOME/bin/
export LC_ALL="C"
export PS1="\[$BICyan\][ \[$Cyan\]\u@\h \[$IWhite\]\W \[$BICyan\]]\[$Color_Off\] "
export EDITOR="/usr/bin/vim"

stty erase 

if [[ "$HOSTNAME" == *hep.ph.ic.ac.uk ]]; then
    export PS1="\[$BIBlack$On_White\][ \[$Black$On_White\]\u@\h \[$IBlack$On_White\]\W \[$BIBlack$On_White\]]\[$Color_Off\] "
#    export TERM="xterm-256color"
    export SCRAM_ARCH=slc5_amd64_gcc462
    export X509_USER_PROXY=/home/hep/sr505/.MyProxy
    source /vols/cms/grid/setup.sh -arch=slc5_amd64_gcc462
elif [[ "$HOSTNAME" == *.fnal.gov ]]; then
    source /uscmst1/prod/grid/gLite_SL5.sh
    source /uscmst1/prod/sw/cms/bashrc prod
    export SCRAM_ARCH=slc5_amd64_gcc462
#    export TERM="xterm-256color"
    source /uscmst1/prod/sw/cms/cmsset_default.sh
fi
