#!/usr/bin/env bash

time=$( date +"%0H%0M" )
if [[ $time -le 0600 ]] || [[ $time -ge 1900 ]]
then
    touch /tmp/tmux-time.txt
    isNight=$( cat /tmp/tmux-time.txt )
    if [[ "$isNight" -ne 0 ]]
    then
        echo -n "0" > /tmp/tmux-time.txt
        rm -f /tmp/tmux-date.txt
        ~/.tmux/themes/style/block.sh
    fi
    exit
else
    echo -n "1" > /tmp/tmux-time.txt
fi

dateOfWeek=$( date +"%a" )
touch /tmp/tmux-date.txt
currentDate=$( cat /tmp/tmux-date.txt )
if [ "$dateOfWeek" == "$currentDate" ]
then
    exit
fi

echo -n $dateOfWeek > /tmp/tmux-date.txt
~/.tmux/themes/style/block.sh
