#!/bin/bash
#
# Install Helix configuration.
set -euo pipefail

HELIX_CONFIG_DIR="${HOME}/.config/helix"
mkdir -p "${HELIX_CONFIG_DIR}"

ln -sf "${DOTFILES}/helix/config.toml" "${HELIX_CONFIG_DIR}/config.toml"

echo "Helix config symlinked to ${HELIX_CONFIG_DIR}/config.toml"
