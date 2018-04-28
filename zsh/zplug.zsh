# zplug

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "b4b4r07/enhancd", use:enhancd.sh

zplug "zsh-users/zsh-autosuggestions"

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load 
