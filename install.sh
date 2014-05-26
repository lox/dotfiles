#!/bin/bash -e
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"
export DOTFILES=`pwd`

# find the installers and run them iteratively
find . -mindepth 2 -name 'install.sh' | while read installer ; do
  echo "running $installer"
  sh -c "$installer"
done
