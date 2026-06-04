# fsgame

Hides the taskbar when playing games on KDE Plasma Wayland. Works on Bazzite, Fedora Kinoite, and any KDE Wayland setup.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/opdude/fsgame/main/install.sh | bash
```

## Uninstall

```bash
curl -sSL https://raw.githubusercontent.com/opdude/fsgame/main/uninstall.sh | bash
```

## Supported games

- Steam Proton games
- Final Fantasy XIV

## Adding support for other games

Edit `~/.local/bin/fsgame` and add a pattern to `GAME_PATTERNS`. The pattern is matched against the window's WM_CLASS.

```bash
GAME_PATTERNS="steam_app_ ffxiv mygame"
```

Then restart the service:

```bash
systemctl --user restart fsgame
```
