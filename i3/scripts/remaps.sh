#!/usr/bin/env bash

# This script is called by i3 on startup.
# Might be not necessary anymore (see xinitrc)

# set the keyboard to mac

# maps caps lock to escape for vim (and ctrl)
xkbcomp $HOME/.dotfiles/X11/xkb.config $DISPLAY && xcape -t 500 -e "ISO_Level3_Shift=Escape"
