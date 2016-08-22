export PATH=/usr/local:$PATH

export M3_HOME=/usr/local/apache-maven-3.3.9
M3=$M3_HOME/bin
export PATH=$M3:$PATH


if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

