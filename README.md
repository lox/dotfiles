# Lachlan's dotfiles

A minimal, carefully maintained collection of dotfiles for macOS. My philosophy is to delete unnecessary configurations as often as possible to keep things simple and maintainable.

## Overview

These dotfiles help configure:
- zsh with plugins (via antidote)
- git configuration
- Homebrew packages and applications
- macOS preferences
- vim, SSH, Docker, and other development tools
- Ghostty terminal and Visual Studio Code settings
- direnv for environment management
- 1Password SSH agent integration for SSH and git commit signing

## Installation

```bash
git clone https://github.com/lox/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

The installation process:
1. Creates symlinks for all `*.symlink` files into your home directory
2. Installs Homebrew packages defined in the Brewfile
3. Runs topic-specific installers for additional setup

## Structure

The repository follows a modular approach:

- `bootstrap.sh`: Main entry point that runs `install.sh` with `caffeinate` to prevent sleep
- `install.sh`: Creates symlinks and runs all topic-specific installers
- `Brewfile`: Defines all Homebrew packages, casks, and fonts to install
- `topic/`: Directories for each tool or area of configuration
- `topic/*.zsh`: Files loaded into your zsh environment
  - Private overrides: files matching `zsh/*.private.zsh` are sourced if present and are gitignored
  - `topic/path.zsh`: Loaded first to set up $PATH
  - `topic/completion.zsh`: Loaded last to set up autocompletion
  - `topic/*.symlink`: Files that get symlinked to your $HOME (e.g., `git/gitconfig.symlink` → `~/.gitconfig`)
  - zsh note: `~/.zshrc` is a small wrapper that sources `${HOME}/.dotfiles/zsh/main.zsh`. You can add host- or user-specific overrides in `~/.dotfiles/zsh/*.private.zsh`.
  - `topic/install.sh`: Topic-specific installation scripts
- `bin/`: Executables that are added to your $PATH

## 1Password / Git Integration

- SSH agent configuration uses the 1Password SSH agent for secure key management
- Git commit signing is configured to use 1Password's SSH signing capabilities
- Multiple git identities can be managed with the `git-assume` function

For detailed documentation on the Git identity management system, see [git/README.md](git/README.md).

## Customizing

To add your own configurations:
1. Create a new directory for your topic
2. Add `.zsh` files for zsh configuration
3. Add `.symlink` files that should be linked to your home directory
4. Create an `install.sh` script if additional setup is needed

## Updating

```bash
cd ~/.dotfiles
git pull
./bootstrap.sh
```

## Thanks to…
- [Caarlos0's dotfiles](https://github.com/caarlos0/dotfiles)
