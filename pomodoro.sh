#!/bin/bash - 
#===============================================================================
#
#          FILE: pomodoro.sh
# 
#         USAGE: ./pomodoro.sh 
# 
#   DESCRIPTION: Simple bash script to give user a little "low-tech" Pomodoro feedback. Enjoy!
# 
#        AUTHOR: Sean E. Martin
#       CREATED: 07/24/2014 16:20
#===============================================================================
set -o nounset                              # Treat unset variables as an error

# included env
. ~/bin/.enviro.pomo

# This where we return everything to "normal" 
stopPomo ()
{
  DISPLAY=:0 notify-send -t 1000 -i ./pomodoro.png "Pomodoro Work ends" "Take a break!"
  echo "Pomodoro Work ends" "Take a break!"
  purple-remote "jabber:setstatus?status=${statusPrime}&message=${messagePrime}"
  killall play
  exit
}

# If we "break" this script, go to the stopPomo function.
trap "stopPomo" SIGINT SIGTERM

# get initial Pidgin status and message
statusPrime=$(purple-remote "jabber:getstatus")
messagePrime=$(purple-remote "jabber:getstatusmessage")

# what should be the Pidgin status during pomo?
statusPomo=unavailable
#statusPomo=away

DISPLAY=:0 notify-send -t 1000 -i ./pomodoro.png "New Pomodoro Work starts" "You have 25 minutes to work."
# 25 minutes timer
play -q -n synth 25:00 brown gain ${POMOGAIN}&

i=25
while (( i>=1 )); do
  while (( i>5 )); do
    DISPLAY=:0 notify-send -t 1000 -i ./pomodoro.png "Pomodoro Work Status" "You have ${i} minutes to work."
    echo "You have ${i} minutes to work."
    purple-remote "jabber:setstatus?status=${statusPomo}&message=${POMOPREMSG}${i}${POMOPOSTMSG}"
    sleep 5$POMOWAITUNITS
    i=$(($i-5))
  done

  while (( i>0 )); do
    DISPLAY=:0 notify-send -t 1000 -i ./pomodoro.png "Pomodoro Work Status" "You have ${i} minutes to work."
    echo "You have ${i} minutes to work."
    purple-remote "jabber:setstatus?status=${statusPomo}&message=${POMOPREMSG}${i}${POMOPOSTMSG}"
    sleep 1$POMOWAITUNITS
    i=$(($i-1))
  done
done

# 5 minute rest timer
play -q -n synth 5:00 white gain $(( ${POMOGAIN} +2 ))&
purple-remote "jabber:setstatus?status=${statusPrime}&message=${messagePrime}"

i=0
while (( i<5 )); do
	sleep 1$POMOWAITUNITS
	i=$(($i+1))
	DISPLAY=:0 notify-send -t 1000 -i ./pomodoro.png "Pomodoro Rest Status" "You have rested ${i} minutes."
	echo "You have rested ${i} minutes."
done
stopPomo
