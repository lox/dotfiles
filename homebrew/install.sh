#!/bin/sh -eux
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

if ! brew cask &> /dev/null ; then
  brew install caskroom/cask/brew-cask
  brew tap caskroom/fonts
  brew tap caskroom/versions
  brew cask install font-inconsolata
  brew cask install font-source-code-pro
fi

brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# Install core homebrew packages
brew install grc coreutils spark pv wget ag hub fasd

