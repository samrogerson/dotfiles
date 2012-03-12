#! /bin/bash
FG_FOCUS="#F0DFAF"
#BG_FOCUS="#1E2320"
BG_FOCUS="#002b36"

#Switch to the given desktop
if [[ ! -z $2 ]]
then
  wmctrl -s $2
fi

#Get all desktop names
DESKTOPS=(`wmctrl -d | cut -d\  -f13`)

#Create the dzen input
#The click action calls the script with argument the clicked desktop, and
#thus both swithes to this desktop and updates the dzen bar.
#
#The wm mappings to switch between desktop should call this script as well
line=""
for d in ${DESKTOPS[@]}
do
    switchTo=`wmctrl -d | grep $d | cut -d\  -f1`
    is_curr=`wmctrl -d | grep $d | grep '*'`
    if [[ $is_curr == ""  ]]
    then
        line+="^ca(1,./bar.sh $1 $switchTo >> $1) $d ^ca()"
    else
        line+="^ca(1,./bar.sh $1 $switchTo >> $1)^bg($BG_FOCUS)^fg($FG_FOCUS) $d ^fg()^bg()^ca()"
    fi
done

echo $line
