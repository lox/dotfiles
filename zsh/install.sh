#!/bin/bash

if ! grep -q '/usr/local/bin/zsh' /etc/shells ; then
  sudo sh -c 'echo "$(which zsh)" >> /etc/shells'
  sudo chsh -s $(which zsh) $(whoami)
fi

antibody bundle <"$DOTFILES/zsh/bundles.txt" >~/.zsh_plugins.sh
antibody update
