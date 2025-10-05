#!/bin/bash
set -euo pipefail

if command -v brew &> /dev/null; then
  if brew list | grep -q "hermit"; then
    echo "Removing hermit from homebrew..."
    brew uninstall hermit
  fi
fi

if [ ! -f "$HOME/bin/hermit" ]; then
  # Remove any existing hermit installations
  for dir in /opt/homebrew/bin /usr/local/bin; do
    if [ -f "$dir/hermit" ] || [ -L "$dir/hermit" ]; then
      echo "Removing existing hermit from $dir..."
      rm -f "$dir/hermit" "$dir/hermit-stable"
    fi
  done

  export HERMIT_BIN_INSTALL_DIR="$HOME/bin"
  curl -fsSL https://github.com/cashapp/hermit/releases/download/stable/install.sh | /bin/bash
fi

# Install Go via hermit for use by other installers (e.g., wtp)
if [ ! -f "$DOTFILES/bin/go" ]; then
  "$DOTFILES/bin/hermit" install go
fi
