#!/bin/bash
# fsgame - Keep game windows above the panel

GAME_PATTERNS="steam_app_"

fix_window() {
    local id cls
    id="$1"
    cls=$(xprop -id "$id" WM_CLASS 2>/dev/null) || return
    for pattern in $GAME_PATTERNS; do
        if echo "$cls" | grep -q "$pattern"; then
            wmctrl -i -r "$id" -b add,above 2>/dev/null
            return
        fi
    done
}

fix_all() {
    wmctrl -l 2>/dev/null | while read -r line; do
        fix_window "$(echo "$line" | cut -d" " -f1)"
    done
}

fix_all

while true; do
    # Block until a matching window appears (zero CPU while idle)
    xdotool search --sync --class steam_app_ >/dev/null 2>&1
    fix_all
    # Stay active while any game windows exist; poll every 3s
    # to catch splash→game window transitions
    while xdotool search --class steam_app_ >/dev/null 2>&1; do
        sleep 3
        fix_all
    done
done
