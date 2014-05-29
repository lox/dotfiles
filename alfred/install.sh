#!/bin/bash -e -x
#
# Alfred specific settings

# Set the sync folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "$DOTFILES/alfred"

# Enable blur hack
defaults write com.runningwithcrayons.Alfred-2 experimentalBlur -int 5