
dm_env() {
  local machine=${1:-99dev}

  eval $(docker-machine inspect ${machine} --format \
  "export DOCKER_HOST=tcp://{{ .Driver.IPAddress }}:2376
  export DOCKER_TLS_VERIFY=1
  export DOCKER_CERT_PATH={{ .HostOptions.AuthOptions.StorePath }}
  export DOCKER_MACHINE_NAME={{ .Name }}
  ")

  export RPROMPT="<docker:${machine}>"
}

dm_env_unset() {
  eval $(docker-machine env --unset)
  unset RPROMPT
}

alias dc=docker-compose
alias dce=docker-compose exec
alias dcr=docker-compose run --rm
alias dcu=docker-compose up --remove-orphans --abort-on-container-exit