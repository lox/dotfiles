#!/bin/bash -eux

DOTFILES=$(cd $(dirname $0)/../; pwd)

$DOTFILES/bin/mount-key-volumes