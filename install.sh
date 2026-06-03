#!/bin/sh
set -eu

REPO="https://raw.githubusercontent.com/opdude/fsgame/main"

BIN="${XDG_BIN_HOME:-$HOME/.local/bin}"
SVC="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

mkdir -p "$BIN" "$SVC"

# If run from a local checkout, use local files
if [ -f "$(dirname "$0")/fsgame.sh" ]; then
    install -m 755 "$(dirname "$0")/fsgame.sh" "$BIN/fsgame"
    install -m 644 "$(dirname "$0")/fsgame.service" "$SVC/fsgame.service"
else
    # Otherwise download from GitHub
    echo "Downloading fsgame..."
    curl -sSL "$REPO/fsgame.sh" -o "$BIN/fsgame"
    curl -sSL "$REPO/fsgame.service" -o "$SVC/fsgame.service"
    chmod 755 "$BIN/fsgame"
fi

systemctl --user daemon-reload
systemctl --user enable --now fsgame.service

echo "fsgame installed and running."
