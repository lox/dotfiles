#!/bin/bash

zsh_bin="$(brew --prefix)/bin/zsh"

if ! grep -q "$zsh_bin" /etc/shells ; then
  echo "$zsh_bin" | sudo tee -a /etc/shells > /dev/null
  sudo chsh -s "$zsh_bin" "$(whoami)"
fi

# manually install fasd, as it's archived
git clone https://github.com/clvv/fasd.git
cd fasd || exit 1
make
PREFIX=$HOME make install
cd .. || exit 1
rm -rf fasd

# install wtp (worktree plus) for git worktree management
if [ -f "$DOTFILES/bin/go" ]; then
  GOBIN=~/bin "$DOTFILES/bin/go" install github.com/satococoa/wtp/cmd/wtp@latest
else
  echo "Skipping wtp installation (go not found in hermit)"
fi

mkdir -p ~/.config

if [ ! -e ~/.config/starship.toml ]; then
  ln -s "$DOTFILES/zsh/starship.toml" ~/.config/starship.toml
fi
