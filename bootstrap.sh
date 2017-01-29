#!/bin/bash -euo pipefail
#
# Bootstrap a fresh system

if [ ! -d $HOME/.dotfiles ] ; then
  git clone --recursive https://github.com/lox/dotfiles.git "$HOME/.dotfiles"
fi

# ensure we have keys loaded
$HOME/.dotfiles/bin/mount-key-volumes
(ssh-add -l | grep -q id_rsa) || ssh-add ~/.ssh/id_rsa

if ! command -v brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

cd $HOME/.dotfiles

# find .symlink files and symlink them to home
for src in $(find `pwd` -name '*.symlink')
do
  dst="$HOME/.$(basename "${src%.*}")"
  echo "linking $src -> $dst"
  ln -sf $src $dst
done

caffeinate -i ./install.sh
