
if [[ -d /usr/local/opt/go ]]; then
  export GOPATH_HOME=$HOME/go
  export GOPATH="$GOPATH_HOME"
  export GOBIN=$GOPATH_HOME/bin
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$GOPATH_HOME/bin:$PATH
fi
