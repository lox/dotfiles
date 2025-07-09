#!/bin/bash
#
# Install VSCode configuration.
set -euo pipefail

VSCODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_CONFIG_DIR"

echo "› Linking VSCode settings"
ln -sfv "$DOTFILES/vscode/settings.json" "$VSCODE_CONFIG_DIR/settings.json"

echo "› Installing VSCode extensions"
EXTENSIONS_FILE="$DOTFILES/vscode/extensions.txt"

if [ -f "$EXTENSIONS_FILE" ]; then
  echo "  Checking installed extensions..."
  # Use comm to find extensions in the file (-1) that are not already installed (-3)
  # Requires sorted input, hence the process substitutions with sort
  EXTENSIONS_TO_INSTALL=$(comm -13 <(code --list-extensions | sort) <(sort "$EXTENSIONS_FILE"))

  if [ -n "$EXTENSIONS_TO_INSTALL" ]; then
    echo "  Installing missing extensions:"
    # Log the extensions that will be installed (indented)
    while IFS= read -r line; do
      echo "    $line"
    done <<< "$EXTENSIONS_TO_INSTALL"
    # Pass only the missing extensions to the install command
    xargs -L 1 code --install-extension <<< "$EXTENSIONS_TO_INSTALL"
    echo "  Missing extension installation complete."
  else
    echo "  All specified extensions are already installed."
  fi
else
  echo "  Skipping extension installation: $EXTENSIONS_FILE not found."
  echo "  You can create it by running: code --list-extensions > \"$EXTENSIONS_FILE\""
fi