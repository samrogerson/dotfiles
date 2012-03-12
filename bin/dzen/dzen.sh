#! /bin/bash

dz_kill() {
    pkill mem.sh
    pkill cpu.sh
    pkill gmail.sh
    pkill network.sh
    pkill date.sh
    pkill bar.sh
    pkill dzen2
}

pipe='/tmp/dzen2-xmonad.pipe'
mk_pipes() {
    if [[ ! -e $pipe ]]
    then
        mkfifo $pipe
    fi
}
rm_pipes() {
    if [[ -e $pipe ]]
    then
        rm $pipe
    fi
}

screen_width=`xdpyinfo | awk '$1 ~ /dimensions/ {split($2,arr,"x"); print int(arr[1])}'`
screen_height=`xdpyinfo | awk '$1 ~ /dimensions/ {split($2,arr,"x"); print int(arr[2])}'`
    
FG='#ccc'
BG='#222'

WIDTH=150
Y=0
FONT="-xos4-terminus-medium-r-normal--12-140-72-72-c-80-iso8859-1"
ACT='button1=togglecollapse;button3=exit'

dzen_args=( -fn $FONT -fg $FG -bg $BG -y $Y -sa l -ta l )

dz_kill
#mk_pipes
./mem.sh | dzen2 ${dzen_args[@]} -x 0 -w 150 -l 3 &
./cpu.sh | dzen2 ${dzen_args[@]} -x 150 -w 150 &
./gmail.sh | dzen2 ${dzen_args[@]} -x 300 -w 150 -l 5 &

dwidth=$((screen_width-150))
./date.sh | dzen2 ${dzen_args[@]} -x $dwidth -w 150 &
nwidth=$((dwidth-200))
./network.sh | dzen2 ${dzen_args[@]} -x $nwidth -w 200 &
sleep 5
dz_kill
