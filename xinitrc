#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# for xfce this is necessary because /etc/xdg/xfce4/xinitrc:114 -nocpp option,
# remove this fixes it
xrdb -merge ~/.Xdefaults

# set mouse pointer
xsetroot -cursor_name left_ptr
# hide out mouse when not in use
unclutter &

# set background using feh
if [[ -f ~/.fehrndbkg.sh ]]; then   
    sh ~/.fehrndbkg.sh & 
elif [[ -f ~/.fehbg ]]; then
    sh ~/.fehbg &
#else
   # feh --bg-scale $BACKGROUND_IMAGE
fi

# start urxvt daemon
urxvtd -q -f -o &

# set out keyboard to match being the uk
setxkbmap gb

# turn off pc speaker
xset -b

# D-Bus
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

# add the fonts we needs (like terminus :) )
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/local/
xset fp rehash
# stop the mouse being retarded
xset m 0 0

#exec ck-launch-session startxfce4
exec xmonad
