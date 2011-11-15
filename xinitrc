#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# for xfce this is necessary because /etc/xdg/xfce4/xinitrc:114 -nocpp option,
# remove this fixes it
xrdb -merge ~/.Xdefaults

# set out keyboard to match being the uk
setxkbmap gb

# add the fonts we needs (like terminus :) )
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/local/
xset fp rehash
# stop the mouse being retarded
xset m 0 0

exec ck-launch-session startxfce4
