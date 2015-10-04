#!/bin/bash -eux
#
# Run all dotfiles installers.
set -e

cd "$(dirname $0)"
export DOTFILES=`pwd`

# If we're on a Mac, let's install stuff
if [ "$(uname -s)" == "Darwin" ] ; then
  zsh/install.sh
  homebrew/install.sh
  osx/install.sh
  sublime/install.sh
  terminal/install.sh
  aws/install.sh
  go/install.sh
  ruby/install.sh
fi

