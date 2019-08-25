#!/bin/bash

# This script is called by i3 on startup.
# Might be not necessary anymore (see xinitrc)

# set the keyboard to mac
# setxkbmap -layout us,ru

# maps caps lock to escape for vim (and ctrl)
setxkbmap -layout us,ru -option 'grp:alt_space_toggle,caps:ctrl_modifier,grp_led:caps' && xcape -e 'Caps_Lock=Escape' &


xmodmap $XDG_CONFIG_HOME/.Xmodmap
