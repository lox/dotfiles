

if (( $+commands[brew] && $+commands[go] )); then
  export GOPATH=~/.go
  export GOBIN=~/.go/bin
  export GOROOT=`brew --prefix go`/libexec
  export PATH=$GOBIN:$PATH
fi

if [[ "$(ls /Library/Java/JavaVirtualMachines | wc -l)" -ne 0 ]] ; then
	export JAVA_HOME="$(/usr/libexec/java_home)"
fi

export EDITOR=vim

