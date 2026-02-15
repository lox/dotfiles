#!/bin/bash
set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mise"

mkdir -p "$CONFIG_DIR"
ln -sf "$DOTFILES/mise/global-config.toml" "$CONFIG_DIR/config.toml"

echo "mise config linked to $CONFIG_DIR/config.toml"
