#!/bin/bash

function is-macos() { [[ "$OSTYPE" =~ ^darwin ]] || return 1; }

function is-executable() {
  type "$1" > /dev/null 2>&1 || return 1;
}

function is-supported() {
  if [ $# -eq 1 ]; then
    if eval "$1" > /dev/null 2>&1; then true; else false; fi
  else
    if eval "$1" > /dev/null 2>&1; then
      echo -n "$2"
    else
      echo -n "$3"
    fi
  fi
}
