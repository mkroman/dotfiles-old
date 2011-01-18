#!/bin/sh

setxkbmap -model apple -layout us -variant mac &
xmodmap ~/.Xmodmap
mpdscribble &

case $WM in
  openbox)
    #cairo-compmgr &
    feh --bg-scale /home/mk/Pictures/logo_black.jpg &
    urxvt -e tmux &
    exec openbox-session
    ;;
  xmonad)
    cairo-compmgr & # wtf, but it looks cool
    xsetroot -cursor_name left_ptr &
    feh --bg-scale /home/mk/Pictures/blue_haze.jpg &
    exec xmonad
    ;;
  *)
    # feh --bg-scale /home/mk/Pictures/pulse.jpg &
    # urxvt -e tmux &
    # exec openbox-session
    exec gnome-session
    ;;
esac
