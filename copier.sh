#! /bin/bash

pathloc="# path:"

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

for item in $dirlist $filelist; 
do
   pathstring=""
   if [[ -d $item ]]; then item="$item/.dirinfo"; fi
   while read line && [[ $pathstring == "" ]]; do
       if [[ $line =~ ^[#\"!] || $line =~ ^$ ]]; then 
           pathstring=`echo $line | grep "$pathloc"`
       else
           break
       fi 
   done < $item
   if [[ $pathstring == "" ]]; then
       continue
   fi
   itempath=${pathstring##*: }
   itempath=`eval echo ${itempath}`
   if [[ ! -d $itempath ]] && [[ ! -f $itempath ]]; then
       ln -s $item $itempath
   fi
done
