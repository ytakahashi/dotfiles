# .zshrc

source ~/dotfiles/zsh/aliases.zsh
source ~/dotfiles/zsh/functions.zsh
source ~/dotfiles/zsh/languages.zsh
source ~/dotfiles/zsh/zinit.zsh
source ~/dotfiles/zsh/miscs.zsh

stty stop undef

bindkey -e
bindkey "^U" backward-kill-line

setopt correct

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

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT='
${vcs_info_msg_0_}
%{${fg[white]}%}[%F{190}%n%f@%F{195}%m%f %2~]
%# %{${reset_color}%}'
