#!/bin/bash

export RBENV_ROOT="$HOME/.rbenv"
export RBENV_PLUGINS="$RBENV_ROOT/plugins"
export PATH="$RBENV_ROOT/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1

git clone https://github.com/sstephenson/rbenv.git "$RBENV_ROOT"
eval "$(rbenv init -)"

cat << EOF > "$RBENV_ROOT/default-gems"
bundler
EOF

mkdir -p "$RBENV_PLUGINS"
git clone https://github.com/garnieretienne/rvm-download.git    "$RBENV_PLUGINS/rvm-download"
git clone https://github.com/sstephenson/ruby-build.git         "$RBENV_PLUGINS/ruby-build"
git clone https://github.com/sstephenson/rbenv-default-gems.git "$RBENV_PLUGINS/rbenv-default-gems"
git clone https://github.com/rkh/rbenv-whatis.git               "$RBENV_PLUGINS/rbenv-whatis"
git clone https://github.com/rkh/rbenv-use.git                  "$RBENV_PLUGINS/rbenv-use"
git clone https://github.com/tpope/rbenv-communal-gems.git      "$RBENV_PLUGINS/rbenv-communal-gems"
git clone https://github.com/nicknovitski/rbenv-gem-update      "$RBENV_PLUGINS/rbenv-gem-update"

brew install openssl libyaml libffi

rbenv install 2.3.1
rbenv use 2.3.1 --global
rbenv communize --all