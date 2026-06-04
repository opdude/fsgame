#!/bin/bash
# fsgame - Keep game windows above the panel

GAME_PATTERNS="steam_app_ ffxiv"

fix_window() {
    local id
    id="$1"
    xprop -id "$id" -f _NET_WM_FULLSCREEN_MONITORS 32c -set _NET_WM_FULLSCREEN_MONITORS "0, 0, 0, 0" 2>/dev/null
    wmctrl -i -r "$id" -b add,above 2>/dev/null
}

fix_all() {
    while read -r line; do
        local id cls
        id=$(echo "$line" | cut -d" " -f1)
        cls=$(xprop -id "$id" WM_CLASS 2>/dev/null) || continue
        for pattern in $GAME_PATTERNS; do
            if echo "$cls" | grep -q "$pattern"; then
                fix_window "$id"
                break
            fi
        done
    done < <(wmctrl -l 2>/dev/null)
}

MATCH="steam_app_|ffxiv"

fix_all

while true; do
    # Block until a matching window appears (zero CPU while idle)
    xdotool search --sync --class "$MATCH" >/dev/null 2>&1
    # Stay active only while games are running
    while [ "$(xdotool search --class "$MATCH" 2>/dev/null | wc -l)" -gt 0 ]; do
        fix_all
        sleep 2
    done
done
