#!/usr/bin/env bash

# transparency
compton -b
# xcompmgr -n &

# wallpaper
feh --bg-fill ~/Pictures/Wallpapers/Wallpaper.jpg

# keyboard layout switcher
setxkbmap -layout us,ru -option 'grp:shifts_toggle'

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

# mount disks
# use this command for disk search: lsblk -f
# udisksctl mount -b /dev/sdb1
# udisksctl mount -b /dev/sdc1

xmonad
