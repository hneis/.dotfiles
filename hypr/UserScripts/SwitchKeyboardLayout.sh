#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# This is for changing kb_layouts. script parameter 0 for first lyaout
# 1 for second layout

get_keyboard_names() {
  hyprctl devices -j | jq -r '.keyboards[].name'
}

change_layout() {
  local got_error=false

  while read -r name; do
    hyprctl switchxkblayout "$name" "$1"
    if [[ $? -eq 0 ]]; then
      echo "Switched the layout for $name."
    else
      >&2 echo "Error while switching the layout for $name."
      got_error=true
    fi
  done <<<"$(get_keyboard_names)"

  if [ "$got_error" = true ]; then
    >&2 echo "Some errors were found during the process..."
    return 1
  fi

  return 0 # All layouts had been cycled successfully
}

if ! change_layout "$1"; then
  notify-send -u low -t 2000 'Keyboard layout' 'Error: Layout change failed'
  >&2 echo "Layout change failed."
  exit 1
fi
