#!/bin/bash -x -e

which brew || ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew cask || brew tap phinze/homebrew-cask && brew install brew-cask

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# desktop apps
brew cask install alfred
brew cask install google-chrome
brew cask install iterm2
brew cask install rdio
brew cask install qlcolorcode
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install sequel-pro
brew cask install skype
brew cask install transmission

# terminal apps
brew install pv
brew install mysql
brew install jq
