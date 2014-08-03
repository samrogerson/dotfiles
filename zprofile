# path: $HOME/.zprofile
#
pathmunge() {
    case ":$PATH:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ]; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
                ;;
    esac
}

case `uname -s` in
    Darwin)
        export CLICOLOR=1
        JAVA6=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
        JAVA7=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home/
        export JAVA6
        export JAVA7
        TRAILS_PATH=/Users/srogerson/tools/trails/bin/unix
        local pyactivate=/Users/srogerson/Library/Enthought/Canopy_64bit/User/bin/activate
        if [[ -f $pyactivate ]]; then
            VIRTUAL_ENV_DISABLE_PROMPT=1 source "$pyactivate"
        fi
        ;;
esac

pathmunge /usr/local/sbin
pathmunge $TRAILS_PATH
pathmunge $HOME/bin
# brew needs this before bin even if its already in the path
PATH=/usr/local/bin:$PATH
export PATH

export JAVA_HOME=$JAVA6

#set a decent size
export HISTSIZE=100000
#ignore duplicate consecuetive lines
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#erase duplicates
export HISTCONTROL=erasedups
#append to the bash_history file on exit, rather than over-writing

export EDITOR="vim"

stty erase 

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )) && $( command -v startx ); then
    exec startx
fi

export PYTHONPATH="$HOME/git/notebooks/pylibs/:$PYTHONPATH"
