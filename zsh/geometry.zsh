
# Configure Geometry zsh theme
# https://github.com/geometry-zsh/geometry

GEOMETRY_PROMPT=(geometry_status geometry_path geometry_firebase)
GEOMETRY_RPROMPT=(geometry_custom_git geometry_exec_time geometry_aws_vault geometry_git_identity geometry_hermit)

export GEOMETRY_GIT_GREP=ag                   # define which grep-like tool to use
export GEOMETRY_COLOR_NO_TIME=1

export GEOMETRY_STATUS_SYMBOL="▲"             # default prompt symbol
export GEOMETRY_STATUS_SYMBOL_ERROR="✗"       # displayed when exit value is != 0
export GEOMETRY_STATUS_COLOR_ERROR="red"      # prompt symbol color when exit value is != 0
export GEOMETRY_STATUS_COLOR="default"        # prompt symbol color
export GEOMETRY_STATUS_COLOR_ROOT="red"       # root prompt symbol color

