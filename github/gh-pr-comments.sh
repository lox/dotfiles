#!/bin/bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: gh-pr-comments.sh [--no-bots] [reviewer] [owner/repo] [pr_number]

Fetch GitHub pull request review comments using the GitHub CLI and jq.

Examples:
  gh-pr-comments.sh
  gh-pr-comments.sh --no-bots
  gh-pr-comments.sh --no-bots johndoe owner/repo 42
  gh-pr-comments.sh copilot

Options:
  --no-bots   Exclude bot comments (only show users).
  -h, --help  Show this help message and exit.
EOF
}

log() {
  printf '%s\n' "$1" >&2
}

fatal() {
  log "Error: $1"
  exit 1
}

ensure_command() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    fatal "Required command '$cmd' not found in PATH."
  fi
}

resolve_repo() {
  local repo="$1"
  if [[ -n "$repo" ]]; then
    printf '%s' "$repo"
    return 0
  fi

  log "No repo specified, detecting from current directory..."
  local detected=""
  if ! detected=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null); then
    fatal "Could not detect repository. Specify owner/repo explicitly."
  fi
  detected=$(printf '%s' "$detected" | tr -d '\n')
  if [[ -z "$detected" ]]; then
    fatal "Could not detect repository. Specify owner/repo explicitly."
  fi
  log "Detected repo: $detected"
  printf '%s' "$detected"
}

resolve_pr() {
  local pr_number="$1"
  if [[ -n "$pr_number" ]]; then
    printf '%s' "$pr_number"
    return 0
  fi

  log "No PR number specified, detecting from current branch..."
  local detected=""
  if ! detected=$(gh pr view --json number -q .number 2>/dev/null); then
    fatal "Could not detect PR number. Provide one explicitly or checkout a PR branch."
  fi
  detected=$(printf '%s' "$detected" | tr -d '\n')
  if [[ -z "$detected" ]]; then
    fatal "Could not detect PR number. Provide one explicitly or checkout a PR branch."
  fi
  log "Detected PR #$detected"
  printf '%s' "$detected"
}

log_filter_status() {
  local no_bots="$1"
  local reviewer="$2"
  local repo="$3"
  local pr_number="$4"

  if [[ "$no_bots" == "true" ]]; then
    log "Filtering: humans only (no bots)"
  else
    log "Filtering: including bots"
  fi

  if [[ -n "$reviewer" ]]; then
    log "Filtering comments by reviewer: $reviewer"
  else
    log "No reviewer filter specified, showing all comments"
  fi

  log "Repository: $repo"
  log "Pull request: #$pr_number"
}

build_jq_filter() {
  local no_bots="$1"
  local reviewer="$2"
  local filter=""

  if [[ "$no_bots" == "true" ]]; then
    if [[ -n "$reviewer" ]]; then
      # shellcheck disable=SC2016
      filter='[ .[] | select(.user.type == "User" and .user.login == $user) | { user: .user.login, diff_hunk, line, start_line, body } ]'
    else
      filter='[ .[] | select(.user.type == "User") | { user: .user.login, diff_hunk, line, start_line, body } ]'
    fi
  else
    if [[ -n "$reviewer" ]]; then
      # shellcheck disable=SC2016
      filter='[ .[] | select(.user.login == $user) | { user: .user.login, diff_hunk, line, start_line, body } ]'
    else
      filter='[ .[] | { user: .user.login, diff_hunk, line, start_line, body } ]'
    fi
  fi

  printf '%s' "$filter"
}

fetch_comments() {
  local repo="$1"
  local pr_number="$2"
  local jq_filter="$3"
  local reviewer="$4"
  local endpoint="repos/${repo}/pulls/${pr_number}/comments"

  if [[ -n "$reviewer" ]]; then
    gh api "$endpoint" --paginate | jq --arg user "$reviewer" "$jq_filter"
  else
    gh api "$endpoint" --paginate | jq "$jq_filter"
  fi
}

gh_comments() {
  local no_bots=false
  local reviewer=""
  local repo=""
  local pr_number=""
  local -a positional=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --no-bots)
        no_bots=true
        shift
        ;;
      -h|--help)
        usage
        return 0
        ;;
      --)
        shift
        while [[ $# -gt 0 ]]; do
          positional+=("$1")
          shift
        done
        break
        ;;
      -*)
        usage >&2
        fatal "Unknown option: $1"
        ;;
      *)
        positional+=("$1")
        shift
        ;;
    esac
  done

  if [[ ${#positional[@]} -gt 0 ]]; then
    reviewer="${positional[0]}"
  fi
  if [[ ${#positional[@]} -gt 1 ]]; then
    repo="${positional[1]}"
  fi
  if [[ ${#positional[@]} -gt 2 ]]; then
    pr_number="${positional[2]}"
  fi
  if [[ ${#positional[@]} -gt 3 ]]; then
    usage >&2
    fatal "Too many arguments."
  fi

  ensure_command gh
  ensure_command jq

  repo=$(resolve_repo "$repo")
  pr_number=$(resolve_pr "$pr_number")
  log_filter_status "$no_bots" "$reviewer" "$repo" "$pr_number"

  local jq_filter
  jq_filter=$(build_jq_filter "$no_bots" "$reviewer")

  fetch_comments "$repo" "$pr_number" "$jq_filter" "$reviewer"
}

gh_comments "$@"
