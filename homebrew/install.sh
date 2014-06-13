#!/bin/sh -x
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

if ! brew cask &> /dev/null ; then
  brew tap phinze/homebrew-cask
  brew install brew-cask
  brew cask install caskroom/fonts/font-symbola
fi

# Install core homebrew packages
brew install grc coreutils spark pv wget ag hub fasd