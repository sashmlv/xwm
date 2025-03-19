#!/bin/sh

# exports:

gtk2rcfiles=$HOME/.gtkrc-2.0

if [ -f $gtk2rcfiles ]; then
   export GTK2_RC_FILES=$gtk2rcfiles
fi

# xresources and keymaps:

sysresources=/etc/X11/xinit/.Xresources

if [ -f $sysresources ]; then
   /usr/bin/xrdb -merge $sysresources
fi

sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysmodmap ]; then
   /usr/bin/xmodmap $sysmodmap
fi

userresources=$HOME/.Xresources

if [ -f $userresources ]; then
   /usr/bin/xrdb -merge $userresources
fi

usermodmap=$HOME/.Xmodmap

if [ -f $usermodmap ]; then
   /usr/bin/xmodmap $usermodmap
fi

xmonadresources=$HOME/.xmonad/.Xresources

if [ -f $xmonadresources ]; then
   /usr/bin/xrdb -merge $xmonadresources
fi

xmonadmodmap=$HOME/.xmonad/.Xmodmap

if [ -f $xmonadmodmap ]; then
   /usr/bin/xmodmap $xmonadmodmap
fi

# xsetroot -cursor_name cross # by default xmonad doesn't set a X cursor

/usr/bin/picom -b --config $HOME/.xmonad/picom.conf

/usr/bin/feh --bg-fill $HOME/Pictures/Wallpapers/Wallpaper.jpg

# for thunar
# /usr/libexec/polkit-gnome-authentication-agent-1 &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

/usr/bin/xmobar $HOME/.xmonad/.Xmobarrc

# not "&" at end is a must
