#!/usr/bin/env zsh

# wtp completion - loads after compinit
if command -v wtp >/dev/null 2>&1; then
  eval "$(wtp completion zsh)"
fi
