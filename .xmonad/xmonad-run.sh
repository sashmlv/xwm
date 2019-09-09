#!/usr/bin/env bash

# transparency
compton -b
# xcompmgr -n &

# wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpg

# keyboard layout switcher
setxkbmap -layout us,ru -option 'grp:alt_space_toggle'

if [ -s ~/.xmonad/.xmodmap ]; then
    xmodmap initialize
    xmodmap ~/.xmonad/.xmodmap
fi

if [ -s ~/.xmonad/.xmobarrc ]; then
    xmobar ~/.xmonad/.xmobarrc &
fi

if [ -s ~/.xmonad/.xresources ]; then
    xrdb -merge -I$HOME ~/.xmonad/.xresources
fi

xmonad
