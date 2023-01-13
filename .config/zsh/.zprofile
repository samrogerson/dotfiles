for cfg_file in $XDG_CONFIG_HOME/user/[0-9][0-9]-*.sh; do
	source "$cfg_file"
done
