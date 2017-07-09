#!/bin/sh

export GEOMETRY_PROMPT_PLUGINS=(exec_time git git_identity)
export PROMPT_GEOMETRY_EXEC_TIME=true
export PROMPT_GEOMETRY_GIT_TIME=false

export GEOMETRY_SYMBOL_PROMPT="▲"                  # default prompt symbol
export GEOMETRY_SYMBOL_RPROMPT="⋮"                 # multiline prompts
export GEOMETRY_SYMBOL_EXIT_VALUE="✗"              # displayed when exit value is != 0
export GEOMETRY_SYMBOL_ROOT="☢"                    # when logged in user is root

export GEOMETRY_COLOR_EXIT_VALUE="red"             # prompt symbol color when exit value is != 0
export GEOMETRY_COLOR_PROMPT="white"               # prompt symbol color
export GEOMETRY_COLOR_ROOT="green"                 # root prompt symbol color
export GEOMETRY_COLOR_DIR="blue"                   # current directory color

