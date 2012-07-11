#! /bin/bash

if [[ -f ~/Projects/mscreen/mscreen ]]; then
    ~/Projects/mscreen/mscreen
    exit
fi

OIFS=$IFS
IFS=','
disconnected=`xrandr | awk '/ disconnected/{ printf $1"," }'`
connected=`xrandr | awk '/ connected/{ printf $1"," }'`
max_res=`xrandr | awk '/[\* ]\+/ { printf $1"," }'`

s=0
for screen in ${connected}; do
    screens[$s]=$screen
    s=$(($s+1))
done

r=0
for res in ${max_res}; do
    resolutions[$r]=$res
    r=$(($r+1))
done

for ds in ${disconnected}; do
    xrandr --output ${ds} --off
done


if [[ ${#resolutions[@]} -ne ${#screens[@]} ]]; then 
    echo "Found ${#screens[@]} screens and ${#resolutions[@]} preferred modes"
    echo "EXITING"
    exit
else
    for((i=0;i<${#resolutions[@]};i+=1)); do
        xrandr --output ${screens[$i]} --mode ${resolutions[$i]}
        if [[ $i -gt 0 ]]; then
            j=$((i-1))
            xrandr --output ${screens[$i]} --right-of ${screens[$j]}
        fi
    done
fi

if [[ -f ~/.fehbg ]]; then
    . ~/.fehbg
fi

IFS=$OIFS
