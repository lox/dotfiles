#!/usr/bin/env zsh

export PNPM_HOME="$HOME/.pnpm"

if [[ ! -d "$PNPM_HOME" ]]; then
  mkdir -p "$PNPM_HOME"
fi

if [[ ":$PATH:" != *":$PNPM_HOME:"* ]]; then
  export PATH="$PNPM_HOME:$PATH"
fi
