
# reload zsh config
alias reload!='. ~/.zshrc'

# Access tailscale command
if [[ -f /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] ; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi
