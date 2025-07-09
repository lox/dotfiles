# reload zsh config
alias reload!='. ~/.zshrc'

# Access tailscale command
if [[ -f /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] ; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

# Claude alias
alias cld='vt claude --dangerously-skip-permissions'

# kubectl with kubecolor
alias k=kubecolor
alias kc=kubecolor
alias kg='kubecolor get'
alias kd='kubecolor describe'
alias kx='kubecolor exec -it'
alias kl='kubecolor logs -f'
alias kp='kubecolor get pods'
alias kn='kubecolor get namespaces'
alias kctx='kubecolor config use-context'
alias kns='kubecolor config set-context --current --namespace'
alias kuns='kubecolor config set-context --current --namespace default'

# kubectl with fzf
kf() {
  local resource
  resource=$(kubecolor api-resources --output=name | fzf --prompt="Select resource type: ")
  [ -n "$resource" ] && kubecolor get "$resource" | fzf --header-lines=1
}

# kubectl port-forward with fzf
kpf() {
  local pod
  pod=$(kubecolor get pods --output=name | fzf --prompt="Select pod: ")
  [ -n "$pod" ] && kubecolor port-forward "$pod" "$@"
}

# kubectl exec with fzf
kxf() {
  local pod
  pod=$(kubecolor get pods --output=name | fzf --prompt="Select pod: ")
  [ -n "$pod" ] && kubecolor exec -it "$pod" -- "$@"
}

# kubectl logs with fzf
klf() {
  local pod
  pod=$(kubecolor get pods --output=name | fzf --prompt="Select pod: ")
  [ -n "$pod" ] && kubecolor logs -f "$pod" "$@"
}

# kubectl delete with fzf
kdf() {
  local resource
  resource=$(kubecolor api-resources --output=name | fzf --prompt="Select resource type: ")
  [ -n "$resource" ] && {
    local selection
    selection=$(kubecolor get "$resource" | fzf --header-lines=1 --multi)
    [ -n "$selection" ] && {
      local names
      names=$(echo "$selection" | awk '{print $1}')
      echo "Deleting: $names"
      echo "$names" | xargs -I {} kubecolor delete "$resource" {}
    }
  }
}
