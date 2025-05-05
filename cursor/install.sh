#!/bin/bash
#
# Install Cursor configuration.
set -euo pipefail

CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_CONFIG_DIR"

echo "› Linking Cursor settings"
ln -sfv "$DOTFILES/cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json"

echo "› Installing Cursor extensions"
EXTENSIONS_FILE="$DOTFILES/cursor/extensions.txt"

if [ -f "$EXTENSIONS_FILE" ]; then
  echo "  Checking installed extensions..."
  # Use comm to find extensions in the file (-1) that are not already installed (-3)
  # Requires sorted input, hence the process substitutions with sort
  EXTENSIONS_TO_INSTALL=$(comm -13 <(cursor --list-extensions | sort) <(sort "$EXTENSIONS_FILE"))

  if [ -n "$EXTENSIONS_TO_INSTALL" ]; then
    echo "  Installing missing extensions:"
    # Log the extensions that will be installed (indented)
    while IFS= read -r line; do
      echo "    $line"
    done <<< "$EXTENSIONS_TO_INSTALL"
    # Pass only the missing extensions to the install command
    xargs -L 1 cursor --install-extension <<< "$EXTENSIONS_TO_INSTALL"
    echo "  Missing extension installation complete."
  else
    echo "  All specified extensions are already installed."
  fi
else
  echo "  Skipping extension installation: $EXTENSIONS_FILE not found."
  echo "  You can create it by running: cursor --list-extensions > \"$EXTENSIONS_FILE\""
fi
