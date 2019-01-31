
export AWS_VAULT_PROMPT=osascript
export AWS_VAULT_BIOMETRICS=true
export AWS_VAULT_KEYCHAIN_NAME=login
export AWS_ASSUME_ROLE_TTL=1h

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
