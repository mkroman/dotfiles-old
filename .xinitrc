#!/bin/sh

export DE=gnome

setxkbmap -model apple -layout us -variant mac
xmodmap ~/.Xmodmap

/bin/sh ~/.fehbg &

mpd &

pidof mpdscribble >& /dev/null
if [ $? -ne 0 ]; then
  mpdscribble --conf ~/.mpdscribble/mpdscribble.conf &
fi

case $WM in
  openbox)
    exec ck-launch-session openbox-session
    ;;
  xmonad)
    exec xmonad;;
esac
