#!/bin/bash

GOPATH=${GOPATH:-$HOME/go}
GOBIN=${GOBIN:-$HOME/go/bin}

#[ -f $GOBIN/gometalinter ] || {
#    mkdir -p "$GOBIN" "$GOPATH/src/github.com/"
#
#    packages=(
#        golang.org/x/tools/cmd/goimports
#    )
#
#    for pkg in ${packages[@]}; do
#        echo "> Installing $pkg"
#        go get -u "$pkg"
#    done
#
#    $GOBIN/gometalinter --install --update
#}
