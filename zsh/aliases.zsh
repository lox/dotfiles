
# reload zsh config
alias reload!='. ~/.zshrc'


# Hermit shell hooks
# See https://cashapp.github.io/hermit/usage/shell/
if command -v hermit >/dev/null 2>&1; then
    eval "$(hermit shell-hooks --print --zsh)"
fi

# Access tailscale command
if [[ -f /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] ; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

# VSCode Insiders
if command -v code-insiders >/dev/null 2>&1 && ! command -v code >/dev/null 2>&1; then
    alias code=code-insiders
fi