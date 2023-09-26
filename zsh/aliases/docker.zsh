alias dcbuild="docker-compose build"
alias dcup="docker-compose up"
alias dcdown="docker-compose down"

alias dockps="docker ps --format '{{.ID}} {{.Names}}'"

docksh() {
  docker exec -it $1 /bin/bash
}
