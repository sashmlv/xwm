#!/usr/bin/env bash

feh --bg-scale /usr/share/backgrounds/wallpaper.jpg

# xmodmap initialize
if [ -s ~/.xmonad/.xmodmap ]; then
    xmodmap ~/.xmonad/.xmodmap
fi

xmonad
