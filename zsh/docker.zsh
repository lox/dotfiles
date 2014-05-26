export DOCKER_HOST="tcp://localhost:4243"

docker_mysql() {
  port=$(docker port mysql-5.6 3306 | cut -f2 -d':')
  mysql -h 0.0.0.0 -P ${port} -u root $@
}

dockervm() {
  pushd ~/Projects/99designs/99dev > /dev/null
  vagrant $@
  popd > /dev/null
}

# docker inspect ip address
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# docker remove containers
drm() {
  test $(docker ps -q | wc -l) -ne 0 && docker stop `docker ps -q`
  test $(docker ps -q -a | wc -l) -ne 0 && docker rm $(docker ps -q -a)
}

# docker remove images
dri() { docker rmi $(docker images -q); }

alias dki="docker run -t -i -P"

# open a docker url
dopen() { open "http://$(docker port $1 $2)" }

dnuke!() {
  drm
  ssh vagrant -C "sudo service docker restart"
}