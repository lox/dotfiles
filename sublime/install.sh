#!/bin/bash -ex

SETTINGS_DIR="$HOME/Library/Application Support/Sublime Text 3"

brew cask install sublime-text-dev

mkdir -p "$SETTINGS_DIR/Packages/" "$SETTINGS_DIR/Installed Packages/" 
cd "$SETTINGS_DIR/Installed Packages/"
wget https://sublime.wbond.net/Package%20Control.sublime-package 

cd "$SETTINGS_DIR/Packages/"
[[ -d User ]] && rm -r User
ln -s ~/Dropbox/Sublime/User
