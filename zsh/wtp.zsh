#!/usr/bin/env zsh

# wtp (Worktree Plus) - Enhanced Git worktree management
# https://github.com/satococoa/wtp

# Initialize wtp shell hook for cd functionality
# Note: completion is handled in wtp/completion.zsh after compinit
# Use absolute path to avoid PATH resolution issues during shell reload
if [[ -x "$HOME/bin/wtp" ]]; then
  eval "$("$HOME/bin/wtp" hook zsh 2>/dev/null)"
elif command -v wtp >/dev/null 2>&1; then
  eval "$(wtp hook zsh 2>/dev/null)"
fi
