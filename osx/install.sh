#!/bin/bash -x -e

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# desktop apps
brew cask install alfred
brew cask install google-chrome
brew cask install iterm2
brew cask install rdio
brew cask install sequel-pro
brew cask install skype
brew cask install transmission

# terminal apps
brew install pv
brew install mysql
brew install jq
