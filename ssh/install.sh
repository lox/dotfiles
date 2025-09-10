#!/bin/sh

set -eu

# Ensure ~/.ssh exists
mkdir -p "$HOME/.ssh"

# Link main SSH config from repo
if [ ! -L "$HOME/.ssh/config" ]; then
  ln -fsv "$DOTFILES/ssh/config" "$HOME/.ssh/config"
fi

# Prefer iCloud-managed private config if present, otherwise create a local file
if [ -f "${ICLOUD_CONFIG}/ssh_config" ]; then
  ln -sfv "${ICLOUD_CONFIG}/ssh_config" "$HOME/.ssh/config.private"
else
  # No iCloud config: ensure a plain local file exists (replace dangling symlink if present)
  if [ -L "$HOME/.ssh/config.private" ]; then
    rm -f "$HOME/.ssh/config.private"
  fi
  [ -f "$HOME/.ssh/config.private" ] || : > "$HOME/.ssh/config.private"
fi
