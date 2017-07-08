#!/bin/bash -euo pipefail
#
# Bootstrap a fresh system
if [ ! -d $HOME/.dotfiles ] ; then
  git clone --recursive https://github.com/lox/dotfiles.git "$HOME/.dotfiles"
fi

# ensure we have keys loaded
(ssh-add -l | grep -qE lachlan@.+\.local) || ssh-add ~/.ssh/id_rsa

# install homebrew
if ! command -v brew ; then
  echo "› Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

cd $HOME/.dotfiles

# find .symlink files and symlink them to home
for src in $(find `pwd` -name '*.symlink') ; do
  echo "› Linking ${dst}..."
  ln -sfv $src "$HOME/.$(basename "${src%.*}")"
done

caffeinate -i ./install.sh
