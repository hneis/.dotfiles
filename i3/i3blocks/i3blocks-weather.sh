#!/usr/bin/env bash

set -euo pipefail

WEATHER_SITE_URL="https://www.gismeteo.ru/weather-tyumen-4501/10-days/"

nm-online -q -t 15 || exit 1

btn_code="${BLOCK_BUTTON:-"0"}"
if [ "${btn_code}" -eq "1" ]; then
  xdg-open $WEATHER_SITE_URL 1> /dev/null &
fi

~/.dotfiles/i3/scripts/weather.sh

exit 0
