#!/bin/zsh

zstyle ':completion::complete:ssh*:*:hosts' command '
  getent hosts; sed -n "s/^Host[=[:blank:]]*/ignored /p" ~/.ssh/config.private'
