#!/bin/sh

test -L ~/.docker/config.json || {
	mkdir -p ~/.docker/
	ln -fsv "$DOTFILES"/docker/config.json ~/.docker/config.json
}
