#!/bin/sh

test -L ~/.gitidentities || {
	ln -sfv "${ICLOUD_CONFIG}/git_identities" ~/.gitidentities
}
