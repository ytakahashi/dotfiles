#!/bin/bash

source lib/color.sh

info "install zplug"

ZPLUG_DIR=$HOME/.zplug
if [ ! -e $ZPLUG_DIR ]; then
  info "installing zplug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  ok "ok : [ zplug ]"
fi


