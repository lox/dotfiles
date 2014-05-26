#!/bin/bash -e

cd "$(dirname $0)"

sbsettings="$HOME/Library/Application Support/Sublime Text 3"

if [ ! -L "$sbsettings/Packages/User" ]; then
  ln -s ./User "$sbsettings/Packages/User"
fi

if [ ! -f "$sbsettings/Installed Packages/Package Control.sublime-package" ]; then
  wget https://sublime.wbond.net/Package%20Control.sublime-package
fi