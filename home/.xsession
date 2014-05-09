#!/bin/sh

setxkbmap -model apple -layout us -variant mac &
xmodmap ~/.Xmodmap &

# Start the pulseaudio daemon
start-pulseaudio-x11 &

exec awesome
