#!/bin/sh

__aws_completion_started=0

__aws_completion_init() {
  test $__aws_completion_started = 0 && {
    source /usr/local/opt/awscli/libexec/bin/aws_zsh_completer.sh
    __aws_completion_started=1
  }
}

aws() {
  __aws_completion_init
  command aws "$@"
}

