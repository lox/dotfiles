#!/bin/sh

test -L ~/.gnupg/gpg-agent.conf || {
  ln -sfv "$DOTFILES"/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
}

test -L ~/.gnupg/gpg.conf || {
  ln -sfv "$DOTFILES"/gpg/gpg.conf ~/.gnupg/gpg.conf
}
