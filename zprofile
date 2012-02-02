# path: $HOME/.zprofile

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
    exec startx
fi
