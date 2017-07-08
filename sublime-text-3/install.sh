#!/bin/sh

ST3_LOCAL="$HOME/Library/Application Support/Sublime Text 3"

# st3 is not installed
test -n "$ST3_LOCAL" || {
  echo "Sublime Text 3 not installed"
  exit 1
}

# create needed directories
mkdir -p "$ST3_LOCAL/Installed Packages"
mkdir -p "$ST3_LOCAL/Packages/User"

# Install Package Control
PKG_CTRL_FILE="$ST3_LOCAL/Installed Packages/Package Control.sublime-package"
[ ! -f "$PKG_CTRL_FILE" ] && curl -o "$PKG_CTRL_FILE" \
  "https://sublime.wbond.net/Package Control.sublime-package"

# Link keymaps
echo "Linking keymaps"
ln -sfv "$DOTFILES/sublime-text-3/Default.sublime-keymap" \
  "$ST3_LOCAL/Packages/User/Default (OSX).sublime-keymap"

# Link all sublime-settings files
echo "Linking settings"
ln -sfv "$DOTFILES"/sublime-text-3/*.sublime-settings "$ST3_LOCAL/Packages/User"
