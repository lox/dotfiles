
# subl() {
#   if [[ -t 0 ]]; then
#     command subl > /dev/null 2>&1
#   fi
#   command subl $@
# }