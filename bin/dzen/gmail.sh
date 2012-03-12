#!/bin/bash
while true ; do
    python check_gmail.py
    sleep 30
done | dzen2 -fn -xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-1 -ta r -l 5 -bg '#808080' -x 700 -w 380
