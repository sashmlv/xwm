#!/bin/sh

# mount disks
# use this command for disk search: lsblk -f
# udisksctl mount -b /dev/sdx1

if ! grep -qs "/run/media/$USER/disk" /proc/mounts; then
   udisksctl mount --block-device `lsblk -Ppo name,label | awk '$2 == "LABEL=\"disk\"" {print $1}' | awk -F \" '{print $2}'` --no-user-interaction
fi

# exec startx $HOME/.cache/xmonad/xmonad-x86_64-linux #
# dbus-launch --sh-syntax --exit-with-session $HOME/.cache/xmonad/xmonad-x86_64-linux # sddm
# $HOME/.xmonad/xmonad-x86_64-linux
dbus-run-session $HOME/.xmonad/xmonad-x86_64-linux # sddm
