#!/bin/bash
set -euo pipefail

CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
XDG_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
THEMES_SRC_DIR="$DOTFILES/ghostty/themes"

mkdir -p "$CONFIG_DIR" "$XDG_CONFIG_DIR"

ln -sf "$DOTFILES/ghostty/config" "$CONFIG_DIR/config"
ln -sf "$DOTFILES/ghostty/config" "$XDG_CONFIG_DIR/config"

link_themes() {
  local destination="$1"
  mkdir -p "$destination"
  if [ -d "$THEMES_SRC_DIR" ]; then
    find "$THEMES_SRC_DIR" -mindepth 1 -maxdepth 1 -type f -print0 | while IFS= read -r -d '' theme; do
      ln -sf "$theme" "$destination/$(basename "$theme")"
    done
  fi
}

link_themes "$CONFIG_DIR/themes"
link_themes "$XDG_CONFIG_DIR/themes"

echo "Ghostty config and themes linked under $CONFIG_DIR and $XDG_CONFIG_DIR"
