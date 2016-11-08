# .bashrc


# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export PATH=${HOME}/.rbenv/bin:${PATH} && \
eval "$(rbenv init -)"


alias ..="cd .."
alias up="cd ..; ls"


alias ssh_ec2ytakahashi='ssh -l ytakahashi -i "/Users/ytakahashi/.ssh/id_rsa" ec2-54-178-82-69.ap-northeast-1.compute.amazonaws.com'



alias z='zsh'
alias t='tmux'

to_trash() {
  for file in $@
  do
    mv $file ~/.Trash
  done
}

cdf () {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]
  then
    cd "$target"
    pwd
  else
    echo 'No Finder window found' >&2
  fi
}

alias rm='to_trash'


alias vbp='vim ~/.bash_profile'
alias vbr='vim ~/.bashrc'
alias vvr='vim ~/.vimrc'
alias sbp='source ~/.bash_profile'

alias ...='cd ../..'
alias ....='cd ../../..'
alias up="cd ..; ls"
alias h='fc -lt '%F %T' 1'
alias lsd='ls -lad $PWD/*'
alias rm='to_trash'
alias sudo='sudo '



# OS specific
case ${OSTYPE} in
  darwin*)
    # for Mac
    export CLICOLOR=1
    alias ls='ls -alFG'
    alias lst='ls -altFG'
    alias f="open ."
    ;;
  linux*)
    # for Linux
    alias ls='ls -laF --color=auto'
    alias lst='ls -latF --color=auto'
    ;;
esac

