#!/bin/bash
#
# path: $HOME/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb ~/.Xdefaults

# add the fonts we needs (like terminus :) )
#xset +fp /usr/share/fonts/truetype/
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/local/

# turn acceleration off
xset m 0 0

# turn off pc speaker
xset -b

# set mouse pointer
xsetroot -cursor_name left_ptr

# compositing
#compton -c -r8 -l-12 -t-8  -b  -G  -f -D30 -I0.45 -O0.45   --paint-on-overlay \
    #--unredir-if-possible  --backend glx --glx-no-stencil #--glx-no-rebind-pixmap

# start up various tools
hash urxvtd && urxvtd -q -f -o &
hash unclutter && unclutter &
hash pms && tmux -2 new -s pms -d pms
hash sabnzbd && sabnzbd &
hash dropboxd && dropboxd &
hash mpd && mpd
hash VBoxClient-all && VBoxClient-all &
hash synclient && synclient PalmDetect=1 &
hash systemd && systemd --user &
# get a nice photo on login
hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &

hash chromium

# set the background
if [[ -d ~/.backgrounds ]]; then
    hsetroot -fill ~/.backgrounds/background
fi

# D-Bus
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

# swap caps lock and escape
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Escape = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Lock = Caps_Lock"

# for the future :)
DEFAULT_SESSION="dwm"
case $1 in
    *)
        hash dwmstatus && dwmstatus &
        hash startdwm && startdwm || exec dwm
        #exec dbus-launch dwm-launch
    ;;
esac
