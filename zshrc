# path: $HOME/.zshrc

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
plugins=(git git-flow)
source $ZSH/oh-my-zsh.sh

if [[ `uname -s` == "Darwin" ]]; then
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
else
    source /usr/share/zsh/site-contrib/powerline.zsh
fi
