#!/bin/bash

readonly GREEN=$(tput setaf 2)
readonly YELLOW=$(tput setaf 3)
readonly NORMAL=$(tput sgr0)

function ok() {
  printf "%s\n" "$GREEN$1$NORMAL"
}

function changed() {
  printf "%s\n" "$YELLOW$1$NORMAL"
}

