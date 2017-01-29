#!/bin/bash -eu

# install any launch agents
mkdir -p "$HOME/Library/LaunchAgents"
cp $DOTFILES/launchd/*.plist "$HOME/Library/LaunchAgents"
