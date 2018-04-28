# aliases

alias ..="cd .."
alias ...='cd ../..'
alias ....='cd ../../..'
alias up="cd ..; ls"

alias z='zsh'
alias t='tmux'

alias lsd='ls -lad $PWD/*'
alias sudo='sudo '

# OS specific
case ${OSTYPE} in
  darwin*)
    # for Mac
    export CLICOLOR=1
    alias ls='ls -aFG'
    alias lst='ls -altFG'
    alias f="open ."
    ;;
  linux*)
    # for Linux
    alias ls='ls -a --color=auto'
    alias lst='ls -latF --color=auto'
    ;;
esac
