#!/usr/bin/env bash

compton -b # transparency
# xcompmgr -n # transparency
feh --bg-scale /usr/share/backgrounds/wallpaper.jpg # wallpaper

xmodmap initialize
if [ -s ~/.xmonad/.xmodmap ]; then
    xmodmap ~/.xmonad/.xmodmap
fi

xmonad
