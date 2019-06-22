#!/usr/bin/env bash

copmton -b # transparency
feh --bg-scale /usr/share/backgrounds/wallpaper.jpg # wallpaper

# xmodmap initialize
if [ -s ~/.xmonad/.xmodmap ]; then
    xmodmap ~/.xmonad/.xmodmap
fi

xmonad
