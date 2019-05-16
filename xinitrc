#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for FILE in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$FILE" ] && . "$FILE"
  done
  unset FILE
fi

# Load .Xresources
if [ -f "$HOME/.Xresources" ]; then
    xrdb "$HOME/.Xresources"
fi

# Keyboard settings.
setxkbmap -model pc105 -layout fr -variant oss -option terminate:ctrl_alt_bksp,compose:rctrl

# Input Method.
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx

# No fucking beep!
xset -b

# Colors temperature adjustments.
redshift-gtk&

# inotify server
twmnd&

# systray
stalonetray&

# Screen locking
xss-lock -- slock&

xsetroot -cursor_name left_ptr
exec xmonad
