#!/usr/bin/env bash

# xmodmap initialize
if [ -s ~/.xmonad/.xmodmap ]; then
    xmodmap ~/.xmonad/.xmodmap
fi

xmonad
