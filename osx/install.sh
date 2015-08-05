#!/bin/bash -x -e

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# desktop apps
brew cask install alfred
brew cask install iterm2
brew cask install rdio
brew cask install sequel-pro
brew cask install skype
brew cask install transmission

# setup php
brew tap homebrew/php
brew install php56

# install any launch agents
cp $DOTFILES/launchd/*.plist ~/Library/LaunchAgents