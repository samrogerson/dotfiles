# path: $HOME/.bashrc

if [ -f ~/.bash_colors ]; then
    source ~/.bash_colors
fi

if [ -f ~/.dir_colors ]; then
    eval `dircolors  ~/.dircolors/dircolors.ansi-light`
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
