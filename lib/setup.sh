#!/bin/bash

source lib/color.sh

count_ok=0
count_changed=0

install_neobundle () {
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
}

home_neobundle() {
  echo ${HOME}/.vim/bundle/neobundle.vim
}

install_zinit() {
  mkdir ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
}

home_zinit() {
  echo "${HOME}/.zinit/bin"
}

echo ""
echo "Install ************************************"

for i in "$@"
do
  DIR=`home_${i}`

  if [ ! -e ${DIR} ]; then
    info "installing ${i}..."
    install_${i}
    let ++count_changed
  else
    ok "ok : [ ${i} ]"
    let ++count_ok
  fi
done

echo ""
echo "Play Recap *********************************"

ok "ok=${count_ok}"
changed "changed=${count_changed}"
