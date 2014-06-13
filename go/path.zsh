
path=("$GOBIN" $path)
export PATH

if (( $+commands[brew] && $+commands[go] )); then
  export GOPATH="$HOME/.go:$HOME/Projects/99designs/go"
  export GOBIN=~/.go/bin
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$GOBIN:$PATH
fi