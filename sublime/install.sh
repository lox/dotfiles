#!/bin/bash -e

cd "$(dirname $0)"

settings_dir="$HOME/Library/Application Support/Sublime Text 3/Packages/User"

# link Sublime Text settings
find `pwd` -iname "*.sublime-settings" | while read f
do
  ln -sf "$f" "$settings_dir/$(basename $f)"
  echo linked $settings_dir/$(basename $f)
done