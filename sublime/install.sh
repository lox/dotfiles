#!/bin/bash -eu

if [[ ! -d ~/Dropbox/Sublime/User ]] ; then
  echo "Failed to find ~/Dropbox/Sublime/User, sync it, then re-run"
  exit 1
fi

SETTINGS_DIR="$HOME/Library/Application Support/Sublime Text 3"

mkdir -p "$SETTINGS_DIR/Packages/" "$SETTINGS_DIR/Installed Packages/"
cd "$SETTINGS_DIR/Installed Packages/"

[[ ! -f "Package Control.sublime-package" ]] && {
  wget https://sublime.wbond.net/Package%20Control.sublime-package
}

cd "$SETTINGS_DIR/Packages/"
[[ -d User ]] && rm -r User

ln -fs ~/Dropbox/Sublime/User User
