# path: $HOME/.profile

if [[ $(uname -s) == "Darwin" ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home/
    TRAILS_PATH=/Users/srogerson/tools/trails/bin/unix
    export PATH=$TRAILS_PATH:$PATH
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
fi

export DISABLE_AUTO_TITLE=true
export EDITOR="vim"
