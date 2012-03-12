#!/bin/sh
#
# (c) 2007, by Robert Manea

# icons
ICONPATH=$HOME/.dzen/icons/dzen_bitmaps/
# network interface
INTERFACE=eth0
# update every x seconds
SLEEP=1
#colors
FG='#ccc'
BG='#222'
#geometry
WIDTH=250
X=917
Y=0
FONT="-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-1"

# Here we remember the previous rx/tx counts
RXB=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
TXB=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

while :; do

    # get new rx/tx counts
    RXBN=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
    TXBN=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`

    # calculate the rates
    # format the values to 4 digit fields
    RXR=$(printf "%4d\n" $(echo "($RXBN - $RXB) / 1024/${SLEEP}" | bc))
    TXR=$(printf "%4d\n" $(echo "($TXBN - $TXB) / 1024/${SLEEP}" | bc))

    # print out the rates with some nice formatting
    echo "${INTERFACE}: ^fg(white)${RXR} kB/s^fg(#80AA83)^p(3)^i(${ICONPATH}/arr_down.xbm)^fg(white)${TXR} kB/s^fg(orange3)^i(${ICONPATH}/arr_up.xbm)^fg()"

    # reset old rates
    RXB=$RXBN; TXB=$TXBN

    sleep $SLEEP
done | dzen2 -fn $FONT -x $X -y $Y  -tw $WIDTH -fg $FG -bg $BG
