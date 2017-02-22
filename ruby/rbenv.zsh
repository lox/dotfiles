
export PATH="$HOME/.rbenv/bin:$PATH"

rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}