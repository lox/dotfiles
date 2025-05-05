#! /bin/bash

# Create the config directory if it doesn't exist
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"

# Symlink the config file
ln -sf "$DOTFILES/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

echo "Ghostty config symlinked to $HOME/Library/Application Support/com.mitchellh.ghostty/config"
