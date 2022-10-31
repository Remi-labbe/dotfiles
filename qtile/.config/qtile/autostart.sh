#!/bin/sh
picom -b
lxsession &
feh --no-fehbg --bg-center $XDG_DATA_HOME/wall.jpg &
nm-applet --indicator &
autorandr -c &
