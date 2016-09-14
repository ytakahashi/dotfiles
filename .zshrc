
bindkey -e
bindkey "^U" backward-kill-line

setopt correct
setopt ignore_eof

autoload -Uz colors
colors


# completion
autoload -U compinit; compinit
zstyle ':completion:*:default' menu select=1
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
setopt list_types
bindkey "^[[Z" reverse-menu-complete


# change directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups


# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history


# prompt (left)
PROMPT="%{${fg[white]}%}[%n %1~]%#  %{${reset_color}%}"


# prompt (right)
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


# alias
alias ...='cd ../..'
alias ....='cd ../../..'
alias up="cd ..; ls"
alias h='fc -lt '%F %T' 1'
alias lsd='ls -lad $PWD/*'
alias rm='to_trash'
alias sudo='sudo '

alias ssh_ec2ytakahashi='ssh -l ytakahashi -i "/Users/ytakahashi/.ssh/id_rsa" ec2-54-178-82-69.ap-northeast-1.compute.amazonaws.com'



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


# shell function
function pwd-clip() {
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

