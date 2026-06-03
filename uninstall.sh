#!/bin/sh
set -eu

BIN="${XDG_BIN_HOME:-$HOME/.local/bin}"
SVC="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

systemctl --user disable --now fsgame.service 2>/dev/null || true
rm -f "$BIN/fsgame" "$SVC/fsgame.service"
systemctl --user daemon-reload 2>/dev/null || true

echo "fsgame removed."
