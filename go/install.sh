#!/bin/bash

[ "$(which gometalinter)" ] || {
    mkdir -p "$GOPATH/bin" "$GOPATH/src/github.com/"

    packages=(
        github.com/alecthomas/gometalinter
        golang.org/x/tools/cmd/cover
        golang.org/x/tools/cmd/godoc
        github.com/nsf/gocode
        golang.org/x/tools/cmd/guru
        golang.org/x/tools/cmd/goimports
        golang.org/x/tools/cmd/gorename
        github.com/golang/lint/golint
    )

    for pkg in ${packages[@]}; do
        echo "> Installing $pkg"
        go get -u "$pkg"
    done

    "$GOPATH"/bin/gometalinter --install --update
}
