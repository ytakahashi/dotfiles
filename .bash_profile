# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

alias ls='ls -la --color=auto'

export PATH=/usr/local:$PATH

export M3_HOME=/usr/local/apache-maven-3.3.9
M3=$M3_HOME/bin
export PATH=$M3:$PATH

export PATH=/usr/local/bin:$PATH

