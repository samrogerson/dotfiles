#! /usr/bin/bash
while true ; do
    xsetroot -name "$(acpi -b | awk 'sub(/,/,"") {print $3, $4}')"
    sleep 1m
done
