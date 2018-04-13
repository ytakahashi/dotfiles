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
alias prox='export ALL_PROXY=proxy.sonycity.sony.co.jp:10080'
alias prox2='export ALL_PROXY=proxy2.hq.scei.sony.co.jp:10080'
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
    alias pf='echo ssh -L 10080:proxy2.hq.scei.sony.co.jp:10080 yutakahashi@43.2.136.60;ssh -L 10080:proxy2.hq.scei.sony.co.jp:10080 yutakahashi@43.2.136.60'
    alias desktop='echo ssh -L 13389:43.2.130.43:3389 yutakahashi@43.2.136.60;ssh -L 13389:43.2.130.43:3389 yutakahashi@43.2.136.60'
    alias ras='cd /Users/ytakahashi/PycharmProjects/ras;./ras.py'
    alias ras_close='cd /Users/ytakahashi/PycharmProjects/ras;./ras.py --finish'
    alias boko='cd /Users/ytakahashi/Documents/snei-github/ssh-public-key/;python boko.py'
    ;;
  linux*)
    # for Linux
    alias ls='ls -a --color=auto'
    alias lst='ls -latF --color=auto'
    alias boko='cd /home/ytakahashi/files/ssh-public-key/;python boko.py'
    ;;
esac

