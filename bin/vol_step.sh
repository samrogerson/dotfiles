#! /bin/bash

# little script to use alsa's amixer to increment volume

DEVICE_NAME="Master"
STEP_SIZE=10

EG_EXP="Playback [0-9]+ \["

# sure there's a better way of doing this
if [[ $1 == "-" ]]; then
    STEP_SIZE=$(($STEP_SIZE*-1))
fi

x=`amixer get "$DEVICE_NAME" | \
    egrep "$EG_EXP" | \
    awk -v step=$STEP_SIZE -F " " '{ print $3+step}' | \
    xargs -0 amixer set "$DEVICE_NAME"`
