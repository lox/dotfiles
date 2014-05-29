
 GO_PLATFORMS=("darwin/386" "darwin/amd64" 
    "freebsd/386" "freebsd/amd64" "freebsd/arm" "linux/386" "linux/amd64" 
    "linux/arm" "windows/386" "windows/amd64")

go-alias() {
	GOOS=${1%/*}
	GOARCH=${1#*/}
	eval "function go-${GOOS}-${GOARCH} { ( GOOS=${GOOS} GOARCH=${GOARCH} go \$@ ) }"
}

go-platforms-supported() {
  for p in $GO_PLATFORMS ; do 
    if [[ -d $GOROOT/bin/${p//\//_} ]] ; then
      echo $p
    fi 
  done
}

for platform in $(go-platforms-supported); do
  go-alias $platform
done

unset -f go-platforms-supported
unset -f go-alias