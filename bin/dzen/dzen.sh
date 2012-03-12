#! /bin/bash

dz_kill() {
    pkill mem.sh
    pkill cpu.sh
    pkill gmail.sh
    pkill network.sh
    pkill dzen2
}
    
FG='#ccc'
BG='#222'

WIDTH=150
Y=0
FONT="-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-1"
ACT='button1=togglecollapse;button3=exit'

DZEN_OPTS="-fn $FONT -fg $FG -bg $BG -y $Y -sa l -ta l -w $WIDTH"

# gmail -l 5
# mem -l 3

dz_kill
./mem.sh | dzen2 $DZEN_OPTS -x 0 -l 3  &
./cpu.sh | dzen2 $DZEN_OPTS -x 150 &
./gmail.sh | dzen2 $DZEN_OPTS -x 300 -l 5 &
./network.sh | dzen2 $DZEN_OPTS -x 450 &

sleep 10
dz_kill
