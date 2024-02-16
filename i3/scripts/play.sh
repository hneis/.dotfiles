#!/usr/bin/env bash

set -euo pipefail

ICON_PLAYING=$(echo -e "\uf04b")
ICON_PAUSED=$(echo -en "\uf04c")

player_status=$(playerctl status | awk '{print toupper($0)}')
if ! (echo "${player_status}" | grep -qP "^PLAYING|PAUSED$"); then
  exit 0
fi

player_text=$(playerctl metadata --format "{{ artist }} - {{ title }}")

if [ "${player_status}" = "PLAYING" ]; then
  echo "${ICON_PLAYING} ${player_text}"
elif [ "${player_status}" = "PAUSED" ]; then
  echo "${ICON_PAUSED} ${player_text}"
fi

exit 0
