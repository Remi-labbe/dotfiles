#!/bin/sh
# xrdb $XDG_CONFIG_HOME/X/Xresources &
nm-applet --indicator &
dwmblocks &
picom -b
lxsession &
feh --no-fehbg --bg-center $XDG_CONFIG_HOME/wall.jpg &
dunst &
