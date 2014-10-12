
if [[ -d /usr/local/opt/go ]]; then
  export GOPATH_HOME=$HOME/.go
  export GOPATH_WORK=$HOME/Projects/99designs/go
  export GOPATH="$GOPATH_HOME:$GOPATH_WORK"
  export GOBIN=$GOPATH_HOME/bin
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH_HOME/bin:$GOPATH_WORK/bin
fi
