#!/bin/sh
picom -b
lxsession &
feh --no-fehbg --bg-center $XDG_DATA_HOME/wall.png &
nm-applet --indicator &
