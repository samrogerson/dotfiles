#! /bin/bash

pathloc="path:"

# take command line argument to operate on directory
if [[ $# -lt 1 ]];
then
    directory=`pwd`
else
    directory=$1
fi

# get some details of whats running
thisfile=`basename $0`
basedir=${directory##*/}

dirlist=`find $directory -type d -not -name $basedir`
filelist=`find $directory -maxdepth 1 -type f -not -name $thisfile \
                          -not -name ".dirinfo" -not -name "*.swp"`
itemlist=`ls $directory`

for item in $itemlist; 
do
    pathstring=""
    if [[ -d $item ]]; 
    then 
        loc="$item/.dirinfo"; 
    else
        loc=$item
    fi
    while read line && [[ $pathstring == "" ]]; do
        if [[ $line =~ ^[#\"!-] || $line =~ ^$ ]]; then 
            pathstring=`echo $line | grep "$pathloc"`
        else
            break
        fi 
    done < $loc
    if [[ $pathstring == "" ]]; then
        continue
    fi

    itempath=${pathstring##*: }
    itempath=`eval echo ${itempath}`

    if [[ -f $itempath ]] || [[ -d $itempath ]]; then 
        echo "$itempath already exists"
        read -n1 -p "Overwrite $itempath (y/n)?"
        echo
        if [[ "$REPLY" == [yY] ]]; then
            echo Removing $itempath
            rm -r $itempath
        else
            echo Skipping $itempath
            continue
        fi
    fi
    if [[ ! -d $itempath ]] && [[ ! -f $itempath ]]; then
        ln -s $directory/$item $itempath
    fi
done
