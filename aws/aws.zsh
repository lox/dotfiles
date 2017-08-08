
# if [[ -n "$AWS_VAULT" ]] ; then
#   export RPROMPT="<aws:$AWS_VAULT>"
# fi

export AWS_VAULT_PROMPT=osascript
export AWS_VAULT_BIOMETRICS=true

alias aws-vault-dev=$HOME/go/bin/aws-vault

ecr-login() {
  local profile="${1:-}"
  if [[ -n "$profile" ]] ; then
    eval "$(aws-vault exec "$profile" -- aws ecr get-login --no-include-email)"
  elif [[ -n "$AWS_VAULT" ]] ; then
    eval "$(aws ecr get-login)"
  else
    echo "No aws credentials or profile provided"
    return 1
  fi
}
