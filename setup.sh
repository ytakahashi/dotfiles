#!/bin/bash

source lib/color.sh

count_ok=0
count_changed=0

echo ""
echo "Install ************************************"

info "install zplug"
ZPLUG_DIR=${HOME}/.zplug
if [ ! -e ${ZPLUG_DIR} ]; then
  info "installing zplug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  let ++count_changed
else
  ok "ok : [ zplug ]"
  let ++count_ok
fi

echo ""
echo "Play Recap *********************************"

ok "ok=${count_ok}"
changed "changed=${count_changed}"

