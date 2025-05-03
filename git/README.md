# Git Configuration

This directory contains Git configuration files and utilities for managing multiple Git identities with 1Password SSH agent integration.

## Overview

The Git configuration in these dotfiles provides:

- SSH-based commit signing via 1Password
- Multiple identity management with easy switching
- Secure storage of identity configuration in iCloud

## Files

- `gitconfig.symlink`: Main Git configuration file (symlinked to `~/.gitconfig`)
- `gitignore.symlink`: Global Git ignore file (symlinked to `~/.gitignore`)
- `identity.zsh`: Contains functions for managing Git identities
- `install.sh`: Sets up the Git identity system during installation

## Managing Git Identities

### Setup

During installation, `~/.gitidentities` is symlinked from iCloud:
```bash
ln -sfv "${ICLOUD_CONFIG}/git_identities" ~/.gitidentities
```

This keeps your identity configurations in sync across devices while keeping them separate from your public dotfiles.

### Identity Configuration

The `~/.gitidentities` file should contain identity configurations in this format:

```gitconfig
[identity "work"]
    name = Your Work Name
    email = your.email@work.com
    signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJi+0V3m...

[identity "personal"]
    name = Your Personal Name
    email = your.email@personal.com
    signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBl7w9A5f...
```

Each identity section includes:
- `name`: Your display name for commits
- `email`: Your email for commits
- `signingkey`: The SSH public key for signing (managed in 1Password)

### Using Identities

The `identity.zsh` file provides two functions:

1. **git-identities**: Lists available identities from your configuration
   ```bash
   $ git-identities
   personal
   work
   ```

2. **git-assume**: Switches to a specific identity
   ```bash
   $ git-assume work
   ```

### How It Works

When you run `git-assume <identity>`, it:

1. Reads the identity configuration from `~/.gitidentities`
2. Sets `user.name` and `user.email` for the current repository
3. Configures the SSH signing key from 1Password
4. Enables commit signing automatically

This allows for seamless switching between different GitHub/Git accounts while maintaining proper commit attribution and signing.

## 1Password Integration

Git commit signing is configured to use 1Password's SSH signing capabilities:

```gitconfig
[gpg]
    format = ssh

[gpg "ssh"]
    program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign
```

This setup:
- Uses SSH keys stored in 1Password for commit signing
- Keeps your keys secure (never exposed to the filesystem)
- Prompts for authentication with 1Password when signing
