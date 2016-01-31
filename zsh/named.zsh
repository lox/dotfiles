
typeset -A NAMED_DIRS

NAMED_DIRS=(
    work_gopath   ~/Projects/99designs/go
    projects      ~/Projects
    gopath        ~/.go
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