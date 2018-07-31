#!/bin/bash 
set -euo pipefail

# Bootstrap a fresh system
if [ ! -d $HOME/.dotfiles ] ; then
  git clone --recursive https://github.com/lox/dotfiles.git "$HOME/.dotfiles"
fi

# ensure we have keys loaded
if ! ssh-add -l | grep -qE lachlan@.+\.local ; then
  echo "No ssh key loaded"
  exit 1
fi

# install homebrew
if ! command -v brew ; then
  echo -e "\\n› Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

cd $HOME/.dotfiles
caffeinate -i ./install.sh
