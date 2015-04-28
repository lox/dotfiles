#!/bin/bash

brew install zsh
sudo sh -c 'echo "$(which zsh)" >> /etc/shells'
sudo chsh -s $(which zsh) $(whoami)
sudo mv -i /etc/zshenv /etc/zprofile

