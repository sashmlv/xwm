#!/usr/bin/env bash

export LC_TIME="en_US.utf8"

# mount disks
# use this command for disk search: lsblk -f
# udisksctl mount -b /dev/sdx1
udisksctl mount --block-device `lsblk -Ppo name,label | awk '$2 == "LABEL=\"disk\"" {print $1}' | awk -F \" '{print $2}'` --no-user-interaction

xmonad
