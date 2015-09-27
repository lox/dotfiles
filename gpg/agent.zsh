
# https://blog.chendry.org/2015/03/13/starting-gpg-agent-in-osx.html
[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S ${GPG_AGENT_INFO%%:*} ]; then
  export GPG_AGENT_INFO
else
  eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
fi