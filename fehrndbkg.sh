#! /bin/bash

# path: $HOME/.fehrndbkg.sh

shopt -s nullglob
#setopt NULL_GLOB #for zsh
 
cd ~/.wallpaper/

while true; do
    files=()
    for i in *.jpg *.png; do
        [[ -f $i ]] && files+=("$i")
    done
    range=${#files[@]}

    ((range)) && feh --bg-scale "${files[RANDOM % range]}"

    sleep 15m
done
