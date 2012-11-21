#!/bin/bash
#
# path: $HOME/.xinitrc
#
# Executed by startx (run your window manager from here)

# for xfce this is necessary because /etc/xdg/xfce4/xinitrc:114 -nocpp option,
# remove this fixes it
xrdb -merge ~/.Xdefaults

# add the fonts we needs (like terminus :) )
#xset +fp /usr/share/fonts/truetype/
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/local/
xset fp rehash
# stop the mouse being retarded
xset m 0 0
# turn off pc speaker
xset -b
# set out keyboard to match being the uk
#setxkbmap gb
# set mouse pointer
xsetroot -cursor_name left_ptr

# compositing
#xcompmgr &
#compton -cCfFGb -o 0.3

# start urxvt daemon
hash urxvtd && urxvtd -q -f -o &
# hide out mouse when not in use
hash unclutter && unclutter &
# start ps3 media server
hash pms && pms &
# start sabnzbd
hash sabnzbd && sabnzbd &

# set background using feh
if [[ -f ~/.fehbg ]]; then
    . ~/.fehbg &
fi

hash synclient && synclient PalmDetect=1 &

# D-Bus
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

# get a nice photo on login
hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &
hash chromium

if [[ -f $HOME/.dropbox-dist/dropboxd ]]; then
    ~/.dropbox-dist/dropboxd &
fi

# swap caps lock and escape
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Escape = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Lock = Caps_Lock"

hash systemd && systemd --user &

hash dwmstatus && dwmstatus &
## window manager
hash startdwm && startdwm || exec dwm
