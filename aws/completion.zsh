
# auto-complete for above awp
function _aws_profiles {
  reply=( default $(grep profile $AWS_HOME/config | sed -e 's/.*profile \([a-zA-Z0-9_-]*\).*/\1/') )
}

if [ -f /usr/local/bin/aws_zsh_completer.sh ] ; then
  source /usr/local/bin/aws_zsh_completer.sh
fi

compctl -K _aws_profiles awp

