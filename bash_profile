#
# path: $HOME/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$HOSTNAME" != *.hep.ph.ic.ac.uk ]] && [[ "$HOSTNAME" != *.fnal.gov ]] && [[ "$HOSTNAME" != lxplus*.cern.ch ]]; then
    if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
        exec startx
    fi
fi
