
if [[ -n "$AWS_VAULT" ]] ; then
  export RPROMPT="<aws:$AWS_VAULT>"
fi

export AWS_VAULT_PROMPT=osascript

ecr-login() {
  local profile="${1:-}"
  if [[ -n "$profile" ]] ; then
    eval "$(aws-vault exec "$profile" -- aws ecr get-login)"
  elif [[ -n "$AWS_VAULT" ]] ; then
    eval "$(aws ecr get-login)"
  else
    echo "No aws credentials or profile provided"
    return 1
  fi
}
