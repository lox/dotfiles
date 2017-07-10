#!/bin/sh

path+=("$HOME/.composer/vendor/bin")

__php_version_started=0

__php_version_init() {
  test $__php_version_started = 0 && {
    source "$(brew --prefix php-version)/php-version.sh"
    __php_version_started=1
  }
}

php_version() {
  __php_version_init
  command php_version "$@"
}

php() {
  __php_version_init
  command php "$@"
}

# rake() {
#   __php_version_init
#   command rake "$@"
# }

# bundle() {
#   __php_version_init
#   command bundle "$@"
# }

# export PATH="$(brew --prefix php56)/bin:$PATH"

