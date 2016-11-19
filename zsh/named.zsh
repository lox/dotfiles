
typeset -A NAMED_DIRS

NAMED_DIRS=(
    projects      ~/Projects
    gopath        $GOPATH_HOME
    loxgo         ~/Projects/go/src/github.com/lox
)

for key in ${(k)NAMED_DIRS}
do
    if [[ -d ${NAMED_DIRS[$key]} ]]; then
        export $key=${NAMED_DIRS[$key]}
        hash -d -- $key=${NAMED_DIRS[$key]}
    fi
done

function lsdirs () {
    for key in ${(k)NAMED_DIRS}
    do
        printf "%-10s %s\n" $key  ${NAMED_DIRS[$key]}
    done
}