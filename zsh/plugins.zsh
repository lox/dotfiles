# aws_vault
# A geometry plugin for showing the aws-vault session that is active

geometry_aws_vault() {
  [ -n "${AWS_VAULT:-}" ] || return
  echo "${GEOMETRY_GIT_SEPARATOR} aws:${AWS_VAULT}"
}

# git_identity
# A geometry plugin for showing a locks symbol if there is a signing key for a repository

GEOMETRY_GIT_IDENTITY_UNSIGNED_SYMBOL=${GEOMETRY_GIT_IDENTITY_UNSIGNED_SYMBOL:-"🔓"}
GEOMETRY_GIT_IDENTITY_SIGNED_SYMBOL=${GEOMETRY_GIT_IDENTITY_SIGNED_SYMBOL:-"🔒"}

geometry_git_identity() {
  [ -d "$PWD/.git" ] || return

  if signingkey=$(git config "user.signingkey") ; then
    echo "${GEOMETRY_GIT_SEPARATOR} ${GEOMETRY_GIT_IDENTITY_SIGNED_SYMBOL} $(git config user.identity)"
  else
    echo "${GEOMETRY_GIT_SEPARATOR} ${signingkey}${GEOMETRY_GIT_IDENTITY_UNSIGNED_SYMBOL} "
  fi
}

geometry_custom_git() {
  (( $+commands[git] )) || return
  git rev-parse 2>/dev/null || return

  $(git rev-parse --is-bare-repository) \
    && ansi ${GEOMETRY_GIT_COLOR_BARE:=blue} ${GEOMETRY_GIT_SYMBOL_BARE:="⬢"} \
    && return

  local git_info && git_info=(
    geometry_git_rebase
    geometry_git_remote
    geometry_git_branch
    geometry_git_conflicts
    geometry_git_status
  )

  geometry::wrap $PWD $git_info
}

# rosetta2
# A geometry plugin for showing we are in a rosetta2 shell

geometry_rosetta2() {
  [ "$(uname -m)" = "x86_64" ] || return
  echo "${GEOMETRY_GIT_SEPARATOR} rosetta2"
}