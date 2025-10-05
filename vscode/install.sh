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
    # Install extensions one by one, continuing on failures
    while IFS= read -r ext; do
      # Capture output and exit code separately to avoid pipefail issues
      if output=$(code --install-extension "$ext" 2>&1); then
        echo "    ✓ $ext"
      else
        # Check if it's a "not found" error or other failure
        if echo "$output" | grep -q "not found"; then
          echo "    ✗ $ext (not found)"
        else
          echo "    ✗ $ext (failed: ${output%%$'\n'*})"
        fi
      fi
    done <<< "$EXTENSIONS_TO_INSTALL"
    echo "  Extension installation complete."
  else
    echo "  All specified extensions are already installed."
  fi
else
  echo "  Skipping extension installation: $EXTENSIONS_FILE not found."
  echo "  You can create it by running: code --list-extensions > \"$EXTENSIONS_FILE\""
fi
