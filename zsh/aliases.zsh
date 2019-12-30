# aliases

alias ..="cd .."
alias ...='cd ../..'
alias ....='cd ../../..'
alias up="cd ..; ls"

alias z='zsh'
alias t='tmux'

alias ll='ls -la'
alias lsd='ls -lad $PWD/*'
alias sudo='sudo '

alias gget='ghq get'

# https://github.com/maxogden/maintenance-modules#maintenance-bash-scripts
alias pre-version='git diff --exit-code && npm prune && npm install -q && npm test'
alias post-version='npm run --if-present build && git diff --exit-code && git push && git push --tags && npm publish'
alias npm_patch='pre-version && npm version patch && post-version'
alias npm_minor='pre-version && npm version minor && post-version'
alias npm_major='pre-version && npm version major && post-version'

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
