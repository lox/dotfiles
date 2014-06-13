#!/bin/bash -e
#
# Bootstrap a fresh system

if [ ! -d $HOME/.dotfiles ] ; then
  git clone --recursive https://github.com/lox/dotfiles.git "$HOME/.dotfiles"
fi

cd $HOME/.dotfiles

# find .symlink files and symlink them to home
for src in $(find `pwd` -name '*.symlink')
do
  dst="$HOME/.$(basename "${src%.*}")"
  echo "linking $src -> $dst"
  ln -sf $src $dst
done

./install.sh