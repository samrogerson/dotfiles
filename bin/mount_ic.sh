#! /bin/bash

local_folders[0]="/mnt/vols"
local_folders[1]="/mnt/public_html"
remote_folders[0]="/vols"
remote_folders[1]="public_html"

for((i=0;i<${#local_folders[@]};i+=1)); do
    if [[ ! -d $local_folders[$i] ]]; then
        echo "${local_folders[$i]} doesn't exist exists"
        read -n1 -p "Create ${local_folders[$i]} (y/n)?"
        echo
        if [[ "$REPLY" == [yY] ]]; then
            echo Making ${local_folders[$i]}
            sudo mkdir ${local_folders[$i]}
            sudo chown root:users ${local_folders[$i]}
        else
            echo Skipping ${local_folders[$i]}
            continue
        fi
    fi
    sshfs sr505@lx06.hep.ph.ic.ac.uk:${remote_folders[$i]} ${local_folders[$i]}
done
