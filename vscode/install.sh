#!/bin/bash
set -euo pipefail

extensions=(
  alexdima.copy-relative-path
  azemoh.one-monokai
  bierner.markdown-preview-github-styles
  coolbear.systemd-unit-file
  dlech.chmod
  EditorConfig.EditorConfig
  kddejong.vscode-cfn-lint
  redhat.vscode-yaml
  SirTori.indenticator
  timonwong.shellcheck
  vscodevim.vim
  arcticicestudio.nord-visual-studio-code
)

installed=()

while IFS=$'\n' read -r line ; do
  installed+=("$line")
done < <(code --list-extensions 2>/dev/null)

for ext in "${extensions[@]}"; do
  if grep -v -q "$ext" <<< "${installed[*]+"${installed[@]}"}" ; then
    echo "> Installing extension $ext"
    code --install-extension "$ext"
  else
    echo "> Extension $ext is already installed"
  fi
done

echo "> Linking configuration"
ln -sfv "$PWD/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
