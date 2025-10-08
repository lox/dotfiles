#!/usr/bin/env zsh

# wtp completion - loads after compinit
# Use absolute path to avoid PATH resolution issues during shell reload
if [[ -x "$HOME/bin/wtp" ]]; then
  eval "$("$HOME/bin/wtp" completion zsh 2>/dev/null)"
elif command -v wtp >/dev/null 2>&1; then
  eval "$(wtp completion zsh 2>/dev/null)"
fi
