#!/usr/bin/env zsh

_awsctx_profiles() {
  command -v aws >/dev/null 2>&1 || return
  aws configure list-profiles 2>/dev/null | sed '/^[[:space:]]*$/d'
}

_awsctx_regions() {
  local config_file="${AWS_CONFIG_FILE:-$HOME/.aws/config}"
  local -a regions

  if [[ -f "$config_file" ]]; then
    regions+=(
      ${(f)"$(awk -F'=' '/^[[:space:]]*region[[:space:]]*=/{gsub(/[[:space:]]/, "", $2); if ($2 != "") print $2}' "$config_file" | sort -u)"}
    )
  fi

  regions+=(
    af-south-1
    ap-east-1
    ap-east-2
    ap-northeast-1
    ap-northeast-2
    ap-northeast-3
    ap-south-1
    ap-south-2
    ap-southeast-1
    ap-southeast-2
    ap-southeast-3
    ap-southeast-4
    ap-southeast-5
    ap-southeast-7
    ca-central-1
    ca-west-1
    eu-central-1
    eu-central-2
    eu-north-1
    eu-south-1
    eu-south-2
    eu-west-1
    eu-west-2
    eu-west-3
    il-central-1
    me-central-1
    me-south-1
    mx-central-1
    sa-east-1
    us-east-1
    us-east-2
    us-west-1
    us-west-2
    us-gov-east-1
    us-gov-west-1
    cn-north-1
    cn-northwest-1
  )

  print -l ${(ou)regions}
}

awsctx() {
  emulate -L zsh
  setopt local_options no_aliases pipe_fail

  local profile="$1"
  local region="$2"

  case "$profile" in
    -h|--help)
      cat <<'EOF'
usage: awsctx [profile] [region]

Examples:
  awsctx buildkite-sandbox-pipelines-admin ap-southeast-2
  awsctx buildkite-sandbox-pipelines-admin
  awsctx --clear
EOF
      return 0
      ;;
    off|clear|--clear)
      unset AWS_PROFILE AWS_REGION AWS_DEFAULT_REGION
      echo "AWS context cleared"
      return 0
      ;;
  esac

  if [[ -z "$profile" ]]; then
    local current_profile="${AWS_PROFILE:-<unset>}"
    local current_region="${AWS_REGION:-${AWS_DEFAULT_REGION:-<unset>}}"
    echo "AWS profile: ${current_profile}"
    echo "AWS region:  ${current_region}"
    return 0
  fi

  export AWS_PROFILE="$profile"

  if [[ -z "$region" ]] && command -v aws >/dev/null 2>&1; then
    region="$(aws configure get region --profile "$profile" 2>/dev/null)"
  fi

  if [[ -n "$region" ]]; then
    export AWS_REGION="$region"
    export AWS_DEFAULT_REGION="$region"
  else
    unset AWS_REGION AWS_DEFAULT_REGION
  fi

  echo "AWS context: ${AWS_PROFILE}${AWS_REGION:+ (${AWS_REGION})}"
}

_awsctx() {
  local -a profiles regions commands
  local state

  profiles=(${(f)"$(_awsctx_profiles)"})
  regions=(${(f)"$(_awsctx_regions)"})
  commands=(off clear --clear -h --help)

  _arguments \
    '1:profile:->profile' \
    '2:region:->region'

  case "$state" in
    profile)
      if [[ "$PREFIX" == -* ]]; then
        compadd -a commands
      else
        compadd -a profiles
      fi
      ;;
    region)
      compadd -a regions
      ;;
  esac
}
