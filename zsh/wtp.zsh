#!/usr/bin/env zsh

# wtp (Worktree Plus) - Enhanced Git worktree management
# https://github.com/satococoa/wtp

# Initialize wtp shell hook for cd functionality
if command -v wtp >/dev/null 2>&1; then
  eval "$(wtp hook zsh)"
fi
