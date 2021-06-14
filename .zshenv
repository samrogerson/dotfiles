export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}"
source "$ZDOTDIR/.zshenv"

for cfg_file in $XDG_CONFIG_HOME/user/[0-9][0-9]-*.sh; do
	source "$cfg_file"
done
