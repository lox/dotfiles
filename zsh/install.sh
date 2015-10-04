#!/bin/bash

brew install zsh
sudo sh -c 'echo "$(which zsh)" >> /etc/shells'
sudo chsh -s $(which zsh) $(whoami)

# older versions of OSX needed this moved
[[ -f /etc/zshenv ]] && sudo mv -i /etc/zshenv /etc/zprofile

