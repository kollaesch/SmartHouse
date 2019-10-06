#!/usr/bin/env bash
SUBCOMMAND=${1}

function health_command_up() {
  docker-compose --file docker-compose.health.yaml --project-name health up
}

function health_command_down() {
  docker-compose --file docker-compose.health.yaml --project-name health down
}

function health_command_logs() {
  docker-compose --file docker-compose.health.yaml --project-name health logs -f
}

function health_command_start() {
  sudo systemctl start health;
}

function health_command_stop() {
  sudo systemctl stop health;
}

function health_command_restart() {
  sudo systemctl restart health;
}

function health_command_help() {
  echo "
  🏡  SmartHouse health

  $ smart-house health help                                  - print this help message
  $ smart-house health start                                 - start all health stuff
  $ smart-house health stop                                  - stop all health stuff
  $ smart-house health restart                               - restart all health stuff
  "
}

function health_validate_command() {
  if [ "$(type -t health_command_${SUBCOMMAND})" = function ]; then
    return 0
  elif [ -z "$SUBCOMMAND" ]; then
    health_command_help;
    return 1
  else
    echo "Unknown health command: ${SUBCOMMAND}";
    return 1
  fi
}

function health_execute_command() {
  if ! health_validate_command; then
    return 1
  fi
  health_command_${SUBCOMMAND} ${COMMAND_ARGS}
  return $?
}

if ! health_execute_command; then
  return 1
fi