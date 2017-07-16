#!/bin/bash

test -f "${ICLOUD_CONFIG}/aws/config" && {
	mkdir -p ~/.aws
	ln -sfv "${ICLOUD_CONFIG}/aws/config" ~/.aws/config
}
