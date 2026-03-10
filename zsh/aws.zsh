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

_awssh_instances() {
  command -v aws >/dev/null 2>&1 || return

  local ssm_instances ec2_rows
  local -a rows ssm_ids
  local -A ec2_name_by_id ec2_state_by_id

  ec2_rows="$(aws ec2 describe-instances \
    --query 'Reservations[].Instances[].[InstanceId,Tags[?Key==`Name`]|[0].Value,State.Name]' \
    --output text 2>/dev/null)"

  if [[ -n "$ec2_rows" ]]; then
    local id name state
    while IFS=$'\t' read -r id name state; do
      [[ -z "$id" ]] && continue
      [[ "$name" == "None" ]] && name=""
      [[ "$state" == "None" ]] && state=""
      ec2_name_by_id[$id]="$name"
      ec2_state_by_id[$id]="$state"
    done <<<"$ec2_rows"
  fi

  ssm_instances="$({
    aws ssm describe-instance-information \
      --query 'InstanceInformationList[].InstanceId' \
      --output text 2>/dev/null
  } | tr '\t' '\n' | sed '/^[[:space:]]*$/d')"

  if [[ -n "$ssm_instances" ]]; then
    ssm_ids=(${(ou)${(f)ssm_instances}})
    local label
    for id in "${ssm_ids[@]}"; do
      label="${ec2_name_by_id[$id]}"
      if [[ -n "$label" ]] && [[ -n "${ec2_state_by_id[$id]}" ]]; then
        rows+=("${id}"$'\t'"${label} (${ec2_state_by_id[$id]})")
      elif [[ -n "$label" ]]; then
        rows+=("${id}"$'\t'"${label}")
      elif [[ -n "${ec2_state_by_id[$id]}" ]]; then
        rows+=("${id}"$'\t'"${ec2_state_by_id[$id]}")
      else
        rows+=("${id}"$'\t'"SSM managed instance")
      fi
    done

    print -l -- "${rows[@]}"
    return 0
  fi

  # Fallback for regions/profiles where SSM inventory isn't available.
  for id in ${(ok)ec2_name_by_id}; do
    if [[ -n "${ec2_name_by_id[$id]}" ]] && [[ -n "${ec2_state_by_id[$id]}" ]]; then
      rows+=("${id}"$'\t'"${ec2_name_by_id[$id]} (${ec2_state_by_id[$id]})")
    elif [[ -n "${ec2_name_by_id[$id]}" ]]; then
      rows+=("${id}"$'\t'"${ec2_name_by_id[$id]}")
    elif [[ -n "${ec2_state_by_id[$id]}" ]]; then
      rows+=("${id}"$'\t'"${ec2_state_by_id[$id]}")
    else
      rows+=("${id}"$'\t'"EC2 instance")
    fi
  done

  if (( ${#rows[@]} > 0 )); then
    print -l -- ${(ou)rows}
  fi
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

awssh() {
  emulate -L zsh
  setopt local_options no_aliases pipe_fail

  local instance_id="$1"
  shift || true

  case "$instance_id" in
    -h|--help)
      cat <<'EOF'
usage: awssh <instance-id> [aws ssm start-session args...]

Examples:
  awssh i-0123456789abcdef0
  awssh i-0123456789abcdef0 --document-name AWS-StartPortForwardingSession
EOF
      return 0
      ;;
    "")
      echo "usage: awssh <instance-id> [aws ssm start-session args...]" >&2
      return 1
      ;;
  esac

  if ! command -v aws >/dev/null 2>&1; then
    echo "aws CLI not found in PATH" >&2
    return 127
  fi

  aws ssm start-session --target "$instance_id" "$@"
}

_awsctx() {
  local -a profiles regions commands
  local context state state_descr line
  typeset -A opt_args

  profiles=(${(f)"$(_awsctx_profiles)"})
  regions=(${(f)"$(_awsctx_regions)"})
  commands=(off clear --clear -h --help)

  _arguments -C \
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

_awssh() {
  local -a instances descriptions commands completion_rows
  local context state state_descr line
  typeset -A opt_args

  completion_rows=(${(f)"$(_awssh_instances)"})
  commands=(-h --help)

  local row instance_id description
  for row in "${completion_rows[@]}"; do
    instance_id="${row%%$'\t'*}"
    description="${row#*$'\t'}"
    [[ -z "$instance_id" ]] && continue
    instances+=("$instance_id")
    if [[ "$description" == "$row" ]]; then
      descriptions+=("${instance_id} - instance")
    else
      descriptions+=("${instance_id} - ${description}")
    fi
  done

  _arguments -C \
    '(-h --help)1:instance-id:->instance' \
    '(- *)-h[show help]' \
    '(- *)--help[show help]' \
    '*::aws ssm start-session args:_normal'

  case "$state" in
    instance)
      if [[ "$PREFIX" == -* ]]; then
        compadd -a commands
      else
        if (( ${#instances[@]} > 0 )); then
          compadd -d descriptions -- "${instances[@]}"
        else
          _message 'instance id'
        fi
      fi
      ;;
  esac
}
