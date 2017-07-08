
# eval "$(command rbenv init -)"

export RBENV_ROOT="$HOME/.rbenv"
export RBENV_PLUGINS="$RBENV_ROOT/plugins"
export PATH="$RBENV_ROOT/bin:$PATH"

# command -v bundle &>/dev/null || {
#   gem install bundler
#   rbenv rehash
# }