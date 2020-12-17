#!/usr/bin/env bash

mictmp='/tmp/.mic.tmp'
result=

if [ "$1" == 'init' ]; then

   rm -f "$mictmp"
   mkfifo -m 600 "$mictmp"
   result=$(pactl list sources | grep -A 10 $(pactl info | grep "Default Source" | cut -f3 -d" ") | grep "Mute: " | cut -f2 -d" ")

elif [ "$1" == 'toggle' ]; then

   pactl set-source-mute $(pactl info | grep "Default Source" | cut -f3 -d" ") toggle
   result=$(pactl list sources | grep -A 10 $(pactl info | grep "Default Source" | cut -f3 -d" ") | grep "Mute: " | cut -f2 -d" ")
fi

if [ "$result" == 'yes' ]; then

   echo "<fc=#00FF00>•</fc>" > "$mictmp" &

else

   echo "<fc=#FF0000>•</fc>" > "$mictmp" &
fi
