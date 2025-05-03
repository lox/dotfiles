# Cursor Configuration

This directory contains configuration for [Cursor](https://cursor.sh/), a VSCode-based IDE with built-in AI assistance.

## Setup

The `install.sh` script creates a symbolic link from this repository to the Cursor configuration directory at `~/Library/Application Support/Cursor/User/settings.json`.

```bash
# Run the install script
./cursor/install.sh
```

## Configuration Overview

The `settings.json` file is organized into the following sections:

1. **Editor General Settings** - Core editor preferences like font, theme, and auto-save
2. **Terminal Configuration** - Terminal appearance and behavior settings
3. **Language-specific Settings** - Configuration for various programming languages:
   - JavaScript
   - HTML/JSON
   - Terraform
4. **Language Tools and Extensions** - Settings for Go, Python, and other language tools
5. **Cursor-specific Settings** - Settings unique to the Cursor editor
6. **Live Share Configuration** - Settings for the Live Share collaboration feature

## Updating

If you make changes to Cursor settings through the UI, they will automatically be reflected in this repository since the file is symlinked. Make sure to commit these changes to keep your dotfiles in sync.

## Troubleshooting

If settings aren't being applied:

1. Check that the symlink is correctly set up:
   ```bash
   ls -la ~/Library/Application\ Support/Cursor/User/
   ```

2. If needed, run the install script again:
   ```bash
   ./cursor/install.sh
   ```

3. Restart Cursor to ensure settings are reloaded
