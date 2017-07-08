#!/bin/bash

export RBENV_ROOT="$HOME/.rbenv"
export RBENV_PLUGINS="$RBENV_ROOT/plugins"
export RBENV_VERSION=2.3.1

test -d $RBENV_ROOT || {
  git clone https://github.com/sstephenson/rbenv.git "$RBENV_ROOT"
}

eval "$(rbenv init -)"

cat << EOF > "$RBENV_ROOT/default-gems"
bundler
EOF

plugins=(
  https://github.com/garnieretienne/rvm-download.git    
  https://github.com/sstephenson/ruby-build.git         
  https://github.com/sstephenson/rbenv-default-gems.git 
  https://github.com/rkh/rbenv-whatis.git               
  https://github.com/rkh/rbenv-use.git                  
  https://github.com/tpope/rbenv-communal-gems.git      
  https://github.com/nicknovitski/rbenv-gem-update      
)

mkdir -p "$RBENV_PLUGINS"
for plugin in "${plugins[@]}" ; do
  plugin_file=$(basename $plugin)
  plugin_dir="$RBENV_PLUGINS/${plugin_file%.*}"

  test -d $plugin_dir || {
    echo -e "\\n> Installing $plugin"
    git clone "$plugin" "$plugin_dir"
  }
done

if ! rbenv versions | grep -qv "${RBENV_VERSION}" ; then
  rbenv install ${RBENV_VERSION}
fi

rbenv use ${RBENV_VERSION} --global
rbenv communize --all