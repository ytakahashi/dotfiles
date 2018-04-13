# aliases

alias ..="cd .."
alias up="cd ..; ls"

alias z='zsh'
alias t='tmux'


alias vbp='vim ~/.bash_profile'
alias vbr='vim ~/.bashrc'
alias vvr='vim ~/.vimrc'
alias sbp='source ~/.bash_profile'

alias ...='cd ../..'
alias ....='cd ../../..'
alias up="cd ..; ls"
alias local_proxy='export ALL_PROXY=localhost:10080'
alias lsd='ls -lad $PWD/*'
alias sudo='sudo '

alias mkcd=mkcd



# OS specific
case ${OSTYPE} in
  darwin*)
    # for Mac
    export CLICOLOR=1
    alias ls='ls -aFG'
    alias lst='ls -altFG'
    alias f="open ."
    alias et_opt='cd /Users/ytakahashi/Documents/files;java -jar et-otp-1.2.jar'
    alias ras='cd /Users/ytakahashi/PycharmProjects/ras;./ras.py'
    alias ras_close='cd /Users/ytakahashi/PycharmProjects/ras;./ras.py --finish'
    ;;
  linux*)
    # for Linux
    alias ls='ls -a --color=auto'
    alias lst='ls -latF --color=auto'
    ;;
esac

