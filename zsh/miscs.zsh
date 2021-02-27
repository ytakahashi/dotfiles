# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='
  --height 90% --reverse --border
  --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
  --color info:183,prompt:110,spinner:107,pointer:167,marker:215
'

_cdup() {
   cd ..
   zle reset-prompt
}

zle -N _cdup
bindkey '^T' _cdup

_git_fethc_p() {
  echo "git fetch -p"
  git fetch -p
  zle reset-prompt
}

zle -N _git_fethc_p
bindkey '^G^F' _git_fethc_p

_git_status_uall() {
  echo "git status -uall"
  git status -uall
  zle reset-prompt
}

zle -N _git_status_uall
bindkey '^G^G' _git_status_uall

precmd_func() {
  print -Pn "\e]0;${${PWD}##*/}\a"
}

preexec_func() {
  printf "\033]0;%s\a" "${1%% *} | ${${PWD}##*/}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_func
add-zsh-hook preexec preexec_func
