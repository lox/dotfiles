
# reload zsh config
alias reload!='. ~/.zshrc'

# Access tailscale command
if [[ -f /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] ; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

# VSCode Insiders
# if command -v code-insiders >/dev/null 2>&1 && ! command -v code >/dev/null 2>&1; then
#     alias code=code-insiders
# fi
