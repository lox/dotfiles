#!/bin/bash
set -euo pipefail

extensions=(
  vscodevim.vim
  editorconfig.editorconfig
  ms-vscode.go
)

for ext in ${extensions[@]}; do
  echo "> Installing extension $ext"
  code --install-extension "$ext"
done

if [[ -f $HOME/Library/Application\ Support/Code/User/settings.json ]] ; then
  cp $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.backup.json
fi

cp ./settings.json $HOME/Library/Application\ Support/Code/User/settings.json