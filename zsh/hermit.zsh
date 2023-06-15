if command -v hermit >/dev/null 2>&1; then
    export HERMIT_ROOT_BIN="$(brew --prefix)/bin/hermit"
    eval "$(hermit shell-hooks --print --zsh)" >/dev/null
fi