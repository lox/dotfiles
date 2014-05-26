
# auto-complete for above awp
function _aws_profiles {
  reply=( default $(grep profile $AWS_HOME/config | sed -e 's/.*profile \([a-zA-Z0-9_-]*\).*/\1/') )
}

#source `which aws_zsh_completer.sh`
compctl -K _aws_profiles awp