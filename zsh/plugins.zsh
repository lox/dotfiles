#!/usr/bin/env zsh

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

geometry_firebase() {
 local firebase_dir=$(get_firebase_dir)
  [ -n "${firebase_dir}" ] || return

  if [[ -n "${CONNECT_EMULATORS:-}" ]]; then
    echo "Emulator"
    return
  fi

  local config_project_id=$(get_config_project_id)
  local rc_project_id=$(get_rc_project_id "$config_project_id")

  if [[ "$config_project_id" == "prod" || "$rc_project_id" =~ prod ]]; then
    # Use ansi function to set text color to white and background to red
    echo -e "\033[41;37m${config_project_id:-$rc_project_id} 🚨\033[0m"
  else
    echo "${config_project_id:-$rc_project_id}"
  fi
}

get_firebase_dir() {
  local dir="$PWD"

  while [[ $dir != '/' ]]; do
    local target="$dir/firebase.json"
    if [[ -e $target ]]; then
      echo $dir
      break
    else
      dir=$(dirname ${dir:A})
    fi
  done
}

get_config_project_id() {
  local target=$(get_firebase_dir)
  local project_id=$(jq -r --arg target "$target" '.activeProjects[$target]' ~/.config/configstore/firebase-tools.json)
  if [[ $project_id == null ]]; then
    project_id='default'
  fi
  echo ${project_id}
}

get_rc_project_id() {
  local project_id=$1
  local rc_path="$(get_firebase_dir)/.firebaserc"
  echo $(jq -r --arg project_id "$project_id" '.projects[$project_id]' $rc_path)
}

# kube-ps1
# A geometry plugin for showing the current Kubernetes context and namespace

geometry_kube_ps1() {
  (( $+commands[kubectl] )) || return
  local kube_context=$(kubectl config current-context 2>/dev/null)
  local kube_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)

  [ -n "$kube_context" ] || return
  echo "${GEOMETRY_GIT_SEPARATOR} ⎈ ${kube_context}:${kube_namespace:-default}"
}
