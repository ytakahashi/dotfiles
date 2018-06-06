
export PATH=/usr/local:$PATH
export LANG=ja_JP.UTF-8

if [[ -s "/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home" ]]; then
  export JAVA_HOME=$(/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8")
  PATH=$JAVA_HOME/bin:$PATH
fi

export M3_HOME=/usr/local/apache-maven-3.3.9
M3=$M3_HOME/bin
export PATH=$M3:$PATH
export MAVEN_OPTS="-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true"

export SDKMAN_DIR="$HOME/.sdkman"

export PATH=/usr/local/bin:$PATH

export PATH="$HOME/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PIPENV_VENV_IN_PROJECT=true

export PATH=$PATH:"$HOME/.nodebrew/current/bin"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='
  --height 40% --reverse --border
  --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
  --color info:183,prompt:110,spinner:107,pointer:167,marker:215
'


