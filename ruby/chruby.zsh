
RUBY_VERSION=${RUBY_VERSION:-2.2.2}

if [[ -d /usr/local/opt/chruby ]]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  chruby $RUBY_VERSION
fi
