#### Picom compositor for X11:
* ```git clone -b stable/8 https://github.com/yshui/picom.git```
* ```git submodule update --init --recursive```
* ```sudo apt install meson cmake libev-dev libxpm-dev libx11-xcb-dev libxcb-render-util0-dev libxcb-image0-dev libxcb-damage0-dev libxcb-sync-dev libxcb-composite0-dev libxcb-present-dev libxcb-glx0-dev uthash-dev libpixman-1-dev libxcb-xinerama0-dev libconfig-dev libpcre++-dev mesa-common-dev libdbus-1-dev```
* ```meson --buildtype=release . build```
* ```ninja -C build```
* install: ```ninja -C build install```
* uninstall: ```ninja -C build uninstall```