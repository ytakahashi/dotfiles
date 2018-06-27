# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

alias z='zsh'
alias t='tmux'

export PS1="[\u@\h \W]\\$ "
