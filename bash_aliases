#! /bin/bash

# path: $HOME/.bash_aliases

alias ls='ls --color=always'
alias grep='grep --color=always'
alias vimless='vim -u /usr/share/vim/vim70/macros/less.vim'

alias netcfg='sudo netcfg'

# --- GIT --- #
alias gss='git status --short'
alias gb='git branch'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gc='git commit'
alias ga='git add'


if [[ "$HOSTNAME" == *.hep.ph.ic.ac.uk ]]; then
    # --- ROOT --- #
    alias sroot='source /vols/cms03/samr/root/bin/thisroot.sh'
    # --- HEP --- #
    alias QSTAT='/home/hep/sr505/Scripts/QSTAT.py'
    # --- MC --- #
    alias pA='/home/hep/sr505/mastercode-tools-old/processAll.x'
    # --- OLD GIT --- #
#    alias gss='git status'
fi
