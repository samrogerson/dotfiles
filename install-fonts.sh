#!/bin/sh

# ensure ~/.fonts exists
if [ ! -d "~/.fonts" ]; then
    mkdir ~/.fonts
fi

# create the pcf files
#bdftopcf -o ~/.fonts/lemon.pcf lemon.bdf
#bdftopcf -o ~/.fonts/uushi.pcf uushi.bdf

# install the fonts
mkfontdir ~/.fonts
mkfontscale ~/.fonts
xset +fp ~/.fonts
xset fp rehash
fc-cache
fc-cache -fv
