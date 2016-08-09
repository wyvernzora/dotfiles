#!/usr/bin/env bash

# Some user interface functionality.

YES=${TRUE}
NO=${FALSE}

# Clear stdin.
function _ui_clear_stdin() {
  local dummy
  read -r -t 1 -n 100000 dummy
}

# Check for numeric value.
function _ui_is_numeric?() {
  printf "%d" "$1" > /dev/null 2>&1
  return $?
}

# Ask the user a yes/no question.
# Returns ${TRUE} for yes, ${FALSE} for no.
# If the user aborts the question by hitting
# Ctrl+D, the return value defaults to no/${FALSE},
# unless otherwise specified in the second parameter.
function ask() {
  assert "$# -ge 1"

  _ui_clear_stdin

  local message=$1
  if [ $# -gt 1 ]; then
    local default=$2
    local prompt="Y/n"
  else
    local default=${FALSE}
    local prompt="y/N"
  fi

  local yn=""

  read -n 1 -p "$(ansi --bold --yellow " ?? ") ${message}: $(ansi --faint "(${prompt})") " yn

  case ${yn} in
    "Y")
      return ${TRUE}
      ;;
    "N")
      return ${FALSE}
      ;;
    "y")
      return ${TRUE}
      ;;
    "n")
      return ${FALSE}
      ;;
  esac


  # Ctrl-D pressed.
  return ${default}
}

# Let the user enter a variable.
# Optionally specify a default value.
function enter_variable() {
  assert_range $# 1 2

  _ui_clear_stdin

  local message=$1
  local var=""

  if [ $# -eq 2 ]; then
    local default=$2

    read -p "$(ansi --bold --yellow " ?? ") ${message} $(ansi --faint "(${default})") " var

    if [ -z ${var} ]; then
      var=${default}
    fi
  else
    read -p "$(ansi --bold --yellow " ?? ") ${message} " var
  fi

  echo ${var}
}

# Let the user enter a hidden variable (e.g., password).
function enter_variable_hidden() {
  assert_eq $# 1

  _ui_clear_stdin

  local message=$1
  local var=""

  read -s -p "$(ansi --bold --yellow " ?? ") ${message} " var
  echo >&2 # Print the newline to stdout explicitly, since read -s gobbles it away.
  echo ${var}
}

# Let the user enter a numberic variable.
function enter_variable_numeric() {
  assert_range $# 1 2

  local var=""

  while true; do
    var=$(enter_variable "$@")

    if _ui_is_numeric? ${var}; then
      break
    fi
  done

  echo ${var}
}
