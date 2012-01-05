#! /bin/bash

echo Copying dotfiles from $PWD

for f in $( ls -1 ); do
    if [[ $f != *.sh ]] && [[ $f != *.conf ]]; then
        if [[ -f $f ]]; then
            cp -p $f ~/.$f
        elif [[ -d $f ]]; then
            if [[ -d ~/.$f ]]; then
                echo Removing ~/.$f
                rm -r ~/.$f
            fi
            cp -rp $f ~/.$f
        else
            echo $f is neither file nor directory, ignoring
        fi
    fi
done
