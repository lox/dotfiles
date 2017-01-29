
# auto-complete for aws cli
if [ -f "/usr/local/opt/awscli/libexec/bin/aws_zsh_completer.sh" ] ; then
  source /usr/local/opt/awscli/libexec/bin/aws_zsh_completer.sh
fi

# if (( $+commands[aws-vault] )) ; then
#   eval "$(aws-vault --completion-script-zsh)"
# fi