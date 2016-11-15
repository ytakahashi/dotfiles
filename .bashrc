# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

source ~/dotfiles/.shrc

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export PATH=${HOME}/.rbenv/bin:${PATH} && \
eval "$(rbenv init -)"


