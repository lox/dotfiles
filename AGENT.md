# Dotfiles Repository Agent Guide

## Build/Install/Test Commands
- **Install**: `./bootstrap.sh` (main entry point with caffeinate)
- **Install (direct)**: `./install.sh` (creates symlinks and runs topic installers)
- **Update**: `git pull && ./bootstrap.sh`
- **Format shell scripts**: `shfmt -w <file>`
- **Topic-specific installs**: Each topic has `topic/install.sh` for custom setup

## Architecture & Structure
This is a modular dotfiles repository for macOS configuration:
- **Topics**: Each tool/config area has its own directory (zsh/, git/, ssh/, etc.)
- **Symlinks**: Files ending in `.symlink` are linked to `$HOME` (e.g., `zsh/zshrc.symlink` → `~/.zshrc`)
- **ZSH modules**: `*.zsh` files are auto-loaded by zsh, with special handling for `path.zsh` (first) and `completion.zsh` (last)
- **Homebrew**: All packages/apps defined in `Brewfile`
- **1Password integration**: SSH agent and git signing via 1Password

## Code Style & Conventions
- **Shell scripts**: Use `set -euo pipefail` for error handling
- **Git**: Commit signing enabled, verbose commits, force-with-lease for safety
- **ZSH**: Antidote for plugin management, starship prompt, fzf integration
- **Path**: Duplicate removal with typeset -U, custom bins in `$DOTFILES/bin`
- **Naming**: Topic directories use lowercase, install scripts always named `install.sh`
- **Dependencies**: Use Homebrew for all package management, check existence before symlinking
