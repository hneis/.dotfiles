#!/bin/bash

# This script is called by i3 on startup.

# set the keyboard to mac
# setxkbmap -layout us,ru

# maps caps lock to escape for vim (and ctrl)
setxkbmap -layout us,ru -option 'grp:alt_space_toggle,caps:ctrl_modifier,grp_led:caps' && xcape -e 'Caps_Lock=Escape' &


xmodmap ~/.Xmodmap
