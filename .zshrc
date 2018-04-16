# .zshrc

source ~/dotfiles/.shrc

source ~/dotfiles/zsh/aliases.zsh

source ~/dotfiles/zsh/functions.zsh

source ~/dotfiles/zsh/zplug.zsh

stty stop undef

bindkey -e
bindkey "^U" backward-kill-line

setopt correct

autoload -Uz colors
colors

# pyenv
if type pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# rbenv
if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi 

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
PROMPT="
%{${fg[white]}%}[%n@%m %2~]
%# %{${reset_color}%}"


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


