
git-identities() {
  git config --get-regexp '^identity\.' | cut -d"." -f2 | sort -u
}

git-assume() {
  local identity="$1"
  local name
  local email

  if ! name=$(git config "identity.$identity.name") ; then
    echo "Missing name for $identity"
    return 1
  fi

  if ! email=$(git config "identity.$identity.email") ; then
    echo "Missing email for $identity"
    return 1
  fi

  git config user.identity "$identity"
  git config user.name "$name"
  git config user.email "$email"

  if signingkey=$(git config "identity.$identity.signingkey") ; then
    git config user.signingkey "$signingkey"
    git config commit.gpgsign true
  fi
}

github_token_command() {
  local identity
  local token

  identity=$(git config "user.identity")
  token=$(git config "identity.${identity}.githubtoken")

  export GITHUB_TOKEN=$token
  command "$@"
}

hub() {
  github_token_command command hub "$@"
}

goreleaser() {
  github_token_command command goreleaser "$@"
}

vgo() {
  github_token_command command vgo "$@"
}
