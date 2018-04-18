#!/bin/bash

source lib/color.sh

prepare() {
  mkdir -p ~/.vim/colors
}

count_ok=0
count_changed=0

prepare

echo ""
echo "Deploy *************************************"

for file in "$@"
do
  dest=${HOME}/${file}
  if [ -e ${dest} ]; then
    ok "ok: [ ${dest} ]"
    let ++count_ok
  else
    ln -sf ${HOME}/dotfiles/${file} ${dest}
    changed "changed: [ ${dest} ]"
    let ++count_changed
  fi
done

echo ""
echo "Play Recap *********************************"

ok "ok=${count_ok}"
changed "changed=${count_changed}"

