# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls="ls --color=auto"
alias grep='grep --color=auto'

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt histignorealldups
setopt SHARE_HISTORY

autoload -Uz +X compinit && compinit

# Case-insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# Rust env
. "$HOME/.cargo/env"

# Init oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# Autosuggestions
. ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
