#!/bin/bash
#
# Run all dotfiles installers.
set -euo pipefail

cd "$(dirname $0)"
export DOTFILES=`pwd`

echo "Installing Bundle"
brew bundle install

find "$DOTFILES" -name 'install.sh' -mindepth 2 -print0 | while read -d $'\0' file; do
  echo "Running $file"
  bash -x $file
done

echo "Done."
