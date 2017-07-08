#!/bin/sh

test -L ~/.gnupg/gpg-agent.conf || {
  ln -sfv "$DOTFILES"/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
}
