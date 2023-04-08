#!/bin/bash

zsh_bin="$(brew --prefix)/bin/zsh"

if ! grep -q "$zsh_bin" /etc/shells ; then
  sudo sh -c "printf '%s\n' '$zsh_bin'" >> /etc/shells
  sudo chsh -s "$zsh_bin" "$(whoami)"
fi

antibody bundle <"$DOTFILES/zsh/bundles.txt" >~/.zsh_plugins.sh
antibody update
