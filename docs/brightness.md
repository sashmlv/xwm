#### Brightness control:
* enable ```ddc/ci``` feature in monitor settings, and disable brightness autocontrol
* install ```ddcutil```:
* * ```sudo apt install ddcutil```
* * or
* * ```wget https://github.com/rockowitz/ddcutil/archive/v0.9.9.tar.gz```
* * ```tar -zxvf v0.9.9.tar.gz```
* * ```cd ddcutil-0.9.9/```
* * ```sudo apt install autoconf libudev-dev libusb-1.0-0-dev```
* * ```./autogen.sh```
* * ```./configure```
* * ```make```
* * ```sudo make install```
* add user to ```i2c``` group: ```sudo usermod $USER -aG i2c```
* relogin
* get brightness: ```ddcutil --nousb getvcp 10```
* increase brightness: ```ddcutil --nousb setvcp 10 + 5```
* decrease brightness: ```ddcutil --nousb setvcp 10 - 5```
* identify all attached monitors: ```ddcutil --nousb detect```
* set the brightness of the second display: ```ddcutil --nousb setvcp 10 50 --display 2```
