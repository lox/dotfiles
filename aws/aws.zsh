
typeset -A aws_vars
aws_vars[AWS_VPC_ID]=vpc_id

if [[ -n "$AWS_VAULT" ]] ; then
  export RPROMPT="<aws:$AWS_VAULT>"
  for key in ${(k)aws_vars} ; do
    export $key=$(aws configure get ${aws_vars[$key]})
  done
fi

if (( $+commands[aws-vault] )) ; then
  eval "$(aws-vault --completion-script-zsh)"
fi