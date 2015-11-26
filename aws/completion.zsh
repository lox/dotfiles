
source $HOME/.dotfiles/aws/aws-keychain/aws-keychain-completion.zsh

# auto-complete for awp
function _aws_profiles {
  reply=( $(awk '/^\[/ {print $(NF)}' ~/.aws/config | tr -d '[]') )
}

# auto-complete for aws cli
if [ -f "/usr/local/opt/awscli/libexec/bin/aws_zsh_completer.sh" ] ; then
  source /usr/local/opt/awscli/libexec/bin/aws_zsh_completer.sh
fi

compctl -K _aws_profiles awp