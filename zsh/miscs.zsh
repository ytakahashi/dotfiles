
_cdup() {
   cd ..
   zle reset-prompt
}

zle -N _cdup
bindkey '^T' _cdup

precmd_func() {
  print -Pn "\e]0;${${PWD}##*/}\a"
}

preexec_func() {
  printf "\033]0;%s\a" "${1%% *} | ${${PWD}##*/}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_func
add-zsh-hook preexec preexec_func
