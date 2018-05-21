# shell functions

cdf () {
  local target
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]
  then
    cd "$target"
    pwd
  else
    echo 'No Finder window found' >&2
  fi
}

mkcd() {
  mkdir $1;
  cd $1;
}

pwd-clip() {
    local copyToClipboard

    if which pbcopy >/dev/null 2>&1 ; then
        # Mac
        copyToClipboard='pbcopy'
    elif which xsel >/dev/null 2>&1 ; then
        # Linux
        copyToClipboard='xsel --input --clipboard'
    elif which putclip >/dev/null 2>&1 ; then
        # Cygwin
        copyToClipboard='putclip'
    else
        copyToClipboard='cat'
    fi

    # ${=VAR} enables SH_WORD_SPLIT option
    # so ${=VAR] is splited in words, for example "a" "b" "c"
    echo -n $PWD | ${=copyToClipboard}
}

h() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

##
# vim
##
fv() {
  local file depth
  depth=${1:-2}

  file=$(
    find . -type d -name .git -prune -o -type f -maxdepth ${depth} |
    fzf +m
  )

  if [[ -z "$file" ]]; then
      return 0
  fi

  print -z "vim $file"
}

##
# Open browser of ghq-managed git remote repositories.
##
browse() {
  local dir protocol browser
  dir=$(ghq list | fzf +m)

  protocol="https://"

  browser=${1:-"Safari"}

  if [[ -z "$dir" ]]; then
      return 0
  fi

  print -z "open -a $browser $protocol$dir"

}

##
# interactive cd to ghq-managed git local repositories.
##
gd() {
  local dir
  dir=$(ghq list -p | fzf +m)

  if [[ -z "$dir" ]]; then
      return 0
  fi

  cd $dir
  pwd
}

##
# interactive cd to recorded directory.
##
pd() {
  local dir
  dir=$(dirs -lp | fzf +m)

  if [[ -z "$dir" ]]; then
      return 0
  fi

  cd "$dir"
  pwd
}

##
# interactive cd to selected directory under current directory
##
fd() {
  local dir depth
  depth=${1:-1}

  dir=$(
    find . -path '*/\.*' -prune -o -type d -print -maxdepth ${depth} |
    fzf +m
  )

  if [[ -z "$dir" ]]; then
    return 0
  fi

  cd $dir
  pwd
}

##
# interactive ssh to a host listed in ~/.ssh/config
##
fssh () {
  local host
  host=$(
    grep "Host " ~/.ssh/config | 
    grep -v '*' | 
    awk {'print $2'} | 
    fzf +m
  )

  if [[ -z "$host" ]]; then
    return 0
  fi

  print -z "ssh $host"

}

precmd_func() {
  print -Pn "\e]0;${${PWD}##*/}\a"
}

preexec_func() {
  printf "\033]0;%s\a" "${1%% *} | ${${PWD}##*/}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_func
add-zsh-hook preexec preexec_func
