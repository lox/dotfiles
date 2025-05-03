#!/bin/bash
#
# Install Cursor configuration.
set -euo pipefail

CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_CONFIG_DIR"

echo "› Linking Cursor settings"
ln -sfv "$DOTFILES/cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
