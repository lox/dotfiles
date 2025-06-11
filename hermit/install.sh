#!/bin/bash
set -euo pipefail

if command -v brew &> /dev/null; then
  if brew list | grep -q "hermit"; then
    echo "Removing hermit from homebrew..."
    brew uninstall hermit
  fi
fi

if [ ! -f "$HOME/bin/hermit" ]; then
  curl -fsSL https://github.com/cashapp/hermit/releases/download/stable/install.sh | /bin/bash
fi