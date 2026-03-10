#!/usr/bin/env zsh

if typeset -f _awsctx >/dev/null 2>&1; then
  compdef _awsctx awsctx
fi

if typeset -f _awssh >/dev/null 2>&1; then
  compdef _awssh awssh
fi
