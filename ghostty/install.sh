#! /bin/bash

# Create the config directory if it doesn't exist
mkdir -p "/Users/lachlan/Library/Application Support/com.mitchellh.ghostty"

# Symlink the config file
ln -sf "$DOTFILES/ghostty/config" "/Users/lachlan/Library/Application Support/com.mitchellh.ghostty/config"

echo "Ghostty config symlinked to /Users/lachlan/Library/Application Support/com.mitchellh.ghostty/config"
