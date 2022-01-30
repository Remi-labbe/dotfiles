#!/bin/sh
dwmblocks &
picom -b
lxsession &
feh --no-fehbg --bg-center $XDG_CONFIG_HOME/wall.jpg &
dunst &
