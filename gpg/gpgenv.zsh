
# Execute a command in a subshell with decrypted env
gpgenv() {
  local f="$1"
  shift 1

  if [[ ! -f $f ]] ; then
    echo "Can't find $f"
    return 1
  fi

  (
  eval "$(gpg --decrypt $f)"
  eval "$@"
  )
}

gpgenc() {
  gpg -ac "$@"
}

gpgcat() {
  gpg --decrypt "$@"
}

gpgedit() {
  set -x
  local f="$1"
  local tmpfile=".envtmp$$"

  if [[ -f "$f" ]] ; then
    gpg --decrypt "$f" > "$tmpfile"
  fi

  vim "$tmpfile"
  gpg -ac -o "$f" "$tmpfile"
  rm $tmpfile
}
