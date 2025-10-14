#!/usr/bin/env zsh

# task completion - loads after compinit
# Works with hermit-managed task installations
if command -v task >/dev/null 2>&1; then
  eval "$(task --completion zsh 2>/dev/null)"
fi
