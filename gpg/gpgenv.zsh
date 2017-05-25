
# Execute a command in a subshell with decrypted env
gpgenv() {
  local f="$1"
  shift 1

  if [[ ! -f $f ]] ; then
    echo "Can't find $f"
    exit 1
  fi

  (
  eval "$(gpg --decrypt $f)"
  eval "$@"
  )
}
