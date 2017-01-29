
if [[ -n "$AWS_VAULT" ]] ; then
  export RPROMPT="<aws:$AWS_VAULT>"
fi
