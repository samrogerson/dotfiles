#!/bin/sh
#
# path: $HOME/.xinitrc
#
# Executed by startx (run your window manager from here)

# for xfce this is necessary because /etc/xdg/xfce4/xinitrc:114 -nocpp option,
# remove this fixes it
xrdb -merge ~/.Xdefaults

# add the fonts we needs (like terminus :) )
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/local/
xset fp rehash
# stop the mouse being retarded
xset m 0 0
# turn off pc speaker
xset -b
# set out keyboard to match being the uk
setxkbmap gb
# set mouse pointer
xsetroot -cursor_name left_ptr

eval `/usr/bin/ssh-agent`

# start urxvt daemon
urxvtd -q -f -o &
# hide out mouse when not in use
unclutter &



# set background using feh
fehrndbkg="$HOME/bin/fehrndbkg.sh"
if [[ -f $fehrndbkg ]]; then
    sh $fehrndbkg &
fi



# D-Bus
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

# 1280x720 = 720p X220
hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &
hash chromium

### status bar for dwm
#while true
#do
#	VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
#	LOCALTIME=$(date +%Z\=%Y-%m-%dT%H:%M)
#	OTHERTIME=$(TZ=Europe/London date +%Z\=%H:%M)
#	IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware
#	TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"
#
#	if acpi -a | grep off-line > /dev/null
#	then
#		BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
#		xsetroot -name "$IP $BAT $VOL $TEMP $LOCALTIME $OTHERTIME"
#	else
#		xsetroot -name "$IP $VOL $TEMP $LOCALTIME $OTHERTIME"
#	fi
#	sleep 20s
#done &

conky -x 0 -y 0 &
exec dwm

#exec xmonad
