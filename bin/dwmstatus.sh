#! /bin/bash

conky -x 0 -y 0 &

#while true ; do
    #date_str="$( date +"%F %R" )"
    #battery_str="$(acpi -b | awk 'gsub(/,/,"") {print $3, $4}')"
    #xsetroot -name  "$battery_str $date_str "
    #sleep 1m
#done
