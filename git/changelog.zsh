
gh_token() {
  local identity
  local token

  identity=$(git config "user.identity")
  token=$(git config "identity.${identity}.githubtoken")

  if [[ -z "$token" ]] ; then
    echo "No token or identity"
    return 1
  fi

  GITHUB_TOKEN=$token "$@"
}

ghch() {
  gh_token command ghch "$@"
}
