#!/bin/bash
#
# Install a Terminal default

cd "$DOTFILES/terminal"

# Use a modified version of the Pro theme by default in Terminal.app
open ./lox.terminal

sleep 1 # Wait a bit to make sure the theme is loaded

defaults write com.apple.terminal 'Default Window Settings' -string 'Lox'
defaults write com.apple.terminal 'Startup Window Settings' -string 'Lox'