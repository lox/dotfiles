
source $HOME/.dotfiles/aws/keychain/aws-keychain-completion.zsh

# auto-complete for awp
function _aws_profiles {
  reply=( default $(aws-keychain ls | grep -v default) )
}

# auto-complete for aws cli
if [ -f "$(brew --prefix)/opt/awscli/libexec/bin/aws_zsh_completer.sh" ] ; then
  source $(brew --prefix)/opt/awscli/libexec/bin/aws_zsh_completer.sh
fi

compctl -K _aws_profiles awp

