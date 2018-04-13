#!/bin/bash

source lib/color.sh

prepare() {
  mkdir -p ~/.vim/colors
  mkdir -p ~/foo/bar
}

readonly DOT_FILES=( 
  .vimrc 
  .vim/colors/kafka.vim
  .zshrc 
  .zshenv 
  .tmux.conf
  .gitignore_global
)

count_ok=0
count_changed=0

prepare

echo ""
echo "Deploy *************************************"

for file in ${DOT_FILES[@]}; do
  dest=${HOME}/${file}
  echo "${file} => ${dest}"
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
