#!/bin/sh

test -d ~/.ssh || {
	mkdir ~/.ssh
	ssh-keygen -t rsa -b 4096 
}

test -L ~/.ssh/config || {
	ln -fsv "$DOTFILES"/ssh/config ~/.ssh/config
}

test -f "${ICLOUD_CONFIG}/ssh_config" || {
	touch ~/.ssh/config.private
}

test -L ~/.ssh/config.private || {
	ln -sfv "${ICLOUD_CONFIG}/ssh_config" ~/.ssh/config.private
}
