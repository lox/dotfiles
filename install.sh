#!/bin/bash
#
# Run all dotfiles installers.
set -euo pipefail

cd "$(dirname $0)"

export DOTFILES=$(pwd)
export ICLOUD_CONFIG=~/Library/Mobile\ Documents/com\~apple\~CloudDocs/Config

echo -e "\\n> Installing Bundle"
brew bundle install

find "$DOTFILES" -name 'install.sh' -mindepth 2 -print0 | while read -d $'\0' file; do
  echo -e "\\n> Running installer $file"
  bash $file
done

echo "Done."
