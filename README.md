## Xmonad config.

### Installation:
* install ```cabal```: [cabal](https://www.haskell.org/cabal)<br>
required libraries: ```sudo apt install ghc libx11-dev libxinerama-dev libxext-dev libxrandr-dev libxss-dev libxft-dev pkg-config```
* install ```xmonad, xmonad-contrib```: [xmonad](https://xmonad.org/intro.html)<br>
```cabal install xmonad xmonad-contrib xmobar```
* we want choose xmonad at login page:<br>
```sudo nano /usr/share/xsessions/xmonad.desktop```
```
[Desktop Entry]
Encoding=UTF-8
Name=XMonad
Comment=Lightweight tiling window manager
Exec=xmonad
Icon=xmonad.png
Type=XSession
```
* add xmonad into environment path:<br>
```sudo nano ~/.profile```
```
# cabal
export PATH=$PATH":/home/user/.cabal/bin"
# xmonad
export PATH=$PATH":/home/user/.xmonad"
```
* copy directory ```.xmonad``` into ```$HOME```
* install libs from notes/install.md
* run: ```xmonad --recompile```
* reboot and choose xmonad session at login page
