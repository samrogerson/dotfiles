#! /bin/bash

# attempt at mimicking martyn's script

pathloc="# path:"

# take command line argument to operate on
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

# lol symlinking: this way we can just git pull on the base dotfiles directory
# and we get updates immediately
for item in $dirlist $filelist; 
do
   if [[ -d $item ]]; then 
       pathstring=`grep "$pathloc" $item/.dirinfo`
   elif [[ -f $item ]]; then
       pathstring=`grep "$pathloc" $item`
   fi
   itempath=${pathstring##*: }
   itempath=`eval echo ${itempath}`
   if [[ ! -d $itempath ]] && [[ ! -f $itempath ]]; then
       ln -s $item $itempath
   fi
done
