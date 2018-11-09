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
  mauve.terraform
  ms-vscode.Go
  PeterJausovec.vscode-docker
  redhat.vscode-yaml
  SirTori.indenticator
  timonwong.shellcheck
  vscodevim.vim
)

for ext in "${extensions[@]}"; do
  if code --list-extensions 2>/dev/null | grep -v -q "$ext" ; then
    echo "> Installing extension $ext"
    code --install-extension "$ext"
  else
    echo "> Extension $ext is already installed"
  fi
done

if [[ -f $HOME/Library/Application\ Support/Code/User/settings.json ]] ; then
  cp $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.backup.json
fi

cp ./vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
