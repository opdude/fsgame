# fsgame

Keeps game windows above the panel on KDE Plasma Wayland so the taskbar doesn't cover them. Works on Bazzite, Fedora Kinoite, and any KDE Wayland setup.

Detects Steam Proton games automatically by window class. Supports non-Steam games by adding patterns.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/opdude/fsgame/main/install.sh | bash
```

## Uninstall

```bash
curl -sSL https://raw.githubusercontent.com/opdude/fsgame/main/uninstall.sh | bash
```

## How it works

Installs a systemd user service that sets `_NET_WM_STATE_ABOVE` on game windows — the same thing as right-clicking a window and selecting "Force Above". This lifts the game above the panel.

It uses `xdotool search --sync` to **block until a game window appears** — zero CPU while no games are running. Once a game is detected, it runs a lightweight check every 3 seconds to handle splash→game window transitions. When all games close, it goes back to blocking silently.

## Supported games out of the box

- Steam Proton games (window class `steam_app_*`)
- Lutris games using Steam-compatible runners
- Heroic Games Launcher (Epic/GOG) games

## Adding support for non-Steam games

Edit `~/.local/bin/fsgame` and add patterns to `GAME_PATTERNS`:

```bash
GAME_PATTERNS="steam_app_ lutris_ heroic"
```

Then restart the service:

```bash
systemctl --user restart fsgame
```

## Requirements

- KDE Plasma on Wayland
- `wmctrl` and `xprop` (installed by default on most distros)
