#!/usr/bin/env bash

brightnesstmp='/tmp/.brightness.tmp'
result=

if [[ "$1" == 'init' ]]; then

   rm -f "$brightnesstmp"
   mkfifo -m 600 "$brightnesstmp"
   echo ' ' > "$brightnesstmp" &

elif [[ "$1" == 'up' && "$2" == '1' ]]; then

   ddcutil --nousb setvcp 10 + 1

elif [[ "$1" == 'down' && "$2" == '1' ]]; then

   ddcutil --nousb setvcp 10 - 1

elif [[ "$1" == 'up' && "$2" == '5' ]]; then

   ddcutil --nousb setvcp 10 + 5

elif [[ "$1" == 'down' && "$2" == '5' ]]; then

   ddcutil --nousb setvcp 10 - 5

fi

result=$(ddcutil --nousb getvcp 10 | tr -s " " | cut -f 9 -d " " | tr -d ",")
echo "$result" > "$brightnesstmp" &
