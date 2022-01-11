#!/bin/sh
# xrdb $XDG_CONFIG_HOME/X/Xresources &
dwmblocks &
picom &
lxsession &
feh --no-fehbg --bg-center $XDG_CONFIG_HOME/wall.jpg &
