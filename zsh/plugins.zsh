# aws_vault
# A geometry plugin for showing the aws-vault session that is active

geometry_prompt_aws_vault_setup() {
  :
}

geometry_prompt_aws_vault_check() {
  [ -n "${AWS_VAULT:-}" ] || return 1
}

geometry_prompt_aws_vault_render() {
  echo "${GEOMETRY_GIT_SEPARATOR} aws:${AWS_VAULT}"
}

geometry_plugin_register aws_vault

# git_identity
# A geometry plugin for showing a locks symbol if there is a signing key for a repository

GEOMETRY_GIT_IDENTITY_UNSIGNED_SYMBOL=${GEOMETRY_GIT_IDENTITY_UNSIGNED_SYMBOL:-"*"}
GEOMETRY_GIT_IDENTITY_SIGNED_SYMBOL=${GEOMETRY_GIT_IDENTITY_SIGNED_SYMBOL:-"🔒"}

geometry_prompt_git_identity_setup() {
  :
}

geometry_prompt_git_identity_check() {
  # Do nothing if we're not in a repository
  [ -d "$PWD/.git" ] || return 1
}

geometry_prompt_git_identity_render() {
  if signingkey=$(git config "user.signingkey") ; then
    echo "${GEOMETRY_GIT_SEPARATOR} ${GEOMETRY_GIT_IDENTITY_SIGNED_SYMBOL}$(git config user.identity)"
  else
    echo "${GEOMETRY_GIT_SEPARATOR} ${signingkey}${GEOMETRY_GIT_IDENTITY_UNSIGNED_SYMBOL} "
  fi
}

geometry_plugin_register git_identity
