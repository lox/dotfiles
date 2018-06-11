# docker_compose.zsh
# A geometry plugin for showing if a directory has docker-compose services running

# Color definitions
GEOMETRY_DOCKER_MACHINE_FAILED_COLOR=${GEOMETRY_DOCKER_MACHINE_FAILED_COLOR:-red}

# Symbol definitions
GEOMETRY_DOCKER_COMPOSE_AVAILABLE_SYMBOL=${GEOMETRY_DOCKER_COMPOSE_AVAILABLE_SYMBOL:-"[d]"}


geometry_prompt_docker_compose_setup() {
  :
}

geometry_prompt_docker_compose_check() {
  # Do nothing if we don't have a compose file
  [ -f "$PWD/docker-compose.yml" ] || return 1
}

geometry_prompt_docker_compose_render() {
  services="$(docker_compose_count_services)"
  running="$(docker_compose_count_running)"
  exited="$(docker_compose_count_exited)"

  if [[ "$exited" -gt 0 ]] ; then
    exited="$(prompt_geometry_colorize $GEOMETRY_DOCKER_MACHINE_FAILED_COLOR "$exited")"
  fi

  echo " ${GEOMETRY_GIT_SEPARATOR} ${GEOMETRY_DOCKER_COMPOSE_AVAILABLE_SYMBOL} $running/$exited/$services"
}

docker_compose_count_services() {
  docker-compose config --services | grep -c .
}

docker_compose_count_exited() {
  docker-compose ps | tail -n+3 | grep -cE 'Exit \d+\b'
}

docker_compose_count_running() {
  docker-compose ps | tail -n+3 | grep -cvE 'Exit \d+\b'
}

# geometry_plugin_register docker_compose
