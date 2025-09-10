#!/bin/bash
#
# Run all dotfiles installers.
set -euo pipefail

cd "$(dirname $0)"

export DOTFILES=$(pwd)
export ICLOUD_CONFIG=~/Library/Mobile\ Documents/com\~apple\~CloudDocs/Config

echo -e "\\n› Creating symlinks"
# Symlink all *.symlink files (zsh now uses ~/.zshrc hook instead of symlink)
for src in $(find "$(pwd)" -name '*.symlink') ; do
  ln -sfv "$src" "$HOME/.$(basename "${src%.*}")"
done

echo -e "\\n› Ensuring ~/.zshrc includes dotfiles hook"
ZSHRC_TEMPLATE_START="# Dotfiles zshrc hook (BEGIN)"
ZSHRC_TEMPLATE_END="# Dotfiles zshrc hook (END)"
ZSHRC_HOOK=$(cat <<'EOF'
# Dotfiles zshrc hook (BEGIN)
# This file is frequently modified by tools. Keep this small hook
# which sources your real zsh configuration from the dotfiles repo.
DOTFILES="${HOME}/.dotfiles"
# Prefer the new repo-managed zshrc; fall back for older clones
if [ -f "${DOTFILES}/zsh/main.zsh" ]; then
  . "${DOTFILES}/zsh/main.zsh"
elif [ -f "${DOTFILES}/zsh/zshrc.symlink" ]; then
  . "${DOTFILES}/zsh/zshrc.symlink"
fi
# Dotfiles zshrc hook (END)
EOF
)

mkdir -p "$HOME"
touch "$HOME/.zshrc"
if ! grep -q "^${ZSHRC_TEMPLATE_START}$" "$HOME/.zshrc" 2>/dev/null; then
  # Append the hook to the end to minimize interference with existing content
  printf "\n%s\n%s\n" "$ZSHRC_HOOK" >> "$HOME/.zshrc"
  echo "Appended dotfiles hook to ~/.zshrc"
else
  echo "~/.zshrc already contains dotfiles hook"
fi

echo -e "\\n> Installing Bundle"
brew bundle install

find "$DOTFILES" -name 'install.sh' -mindepth 2 -print0 | while read -d $'\0' file; do
  echo -e "\\n> Running installer $file"
  bash -eu -o pipefail $file
done

echo -e "\\n> Done!"
