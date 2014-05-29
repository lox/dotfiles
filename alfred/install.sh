#!/bin/bash -e -x
#
# Alfred specific settings

# disable spotlight on cmd-space so Alfred can use it
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"

# disable spotlight window shortcut
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"

# Alfred prefs
#defaults write com.runningwithcrayons.Alfred-Preferences features.defaultresults.scope -array-add "/usr/local/Cellar/emacs"
#defaults write com.runningwithcrayons.Alfred-Preferences features.defaultresults.scope -array-add "/usr/local/Cellar/macvim"
defaults write com.runningwithcrayons.Alfred-Preferences appearance.theme -string "alfred.theme.lightlarge"
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add key 49
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add mod 1048576
defaults write com.runningwithcrayons.Alfred-Preferences hotkey.default -dict-add string "Space"

# Use Silver Linings theme
#defaults write com.runningwithcrayons.Alfred-Preferences appearance.theme alfred.theme.custom.E7C865B5-D9C3-456E-9F1E-9AFCED86EFD5

# Enable blur hack
defaults write com.runningwithcrayons.Alfred-2 experimentalBlur -int 5

# Set the syncfolder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "$DOTFILES/alfred"
