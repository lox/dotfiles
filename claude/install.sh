#!/bin/bash

set -euo pipefail

# Create .claude directory if it doesn't exist
mkdir -p "$HOME/.claude"

# Create symlinks for Claude settings
ln -sf "$DOTFILES/claude/settings.json.symlink" "$HOME/.claude/settings.json"
ln -sf "$DOTFILES/claude/CLAUDE.md.symlink" "$HOME/.claude/CLAUDE.md"

echo "Claude settings linked successfully"