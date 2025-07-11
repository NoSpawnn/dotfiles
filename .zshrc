# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### Aliases ###
alias ls="ls -a --color=auto"
alias grep='grep --color=auto'
if command -v bat &> /dev/null; then alias cat="bat"; fi
if command -v eza &> /dev/null; then alias ls="eza -al"; fi

### History ###
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups
setopt SHARE_HISTORY
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

### Case-insensitive path-completion ###
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

### Exports ###
export PATH=$PATH:$HOME/.local/bin

### Envs ###
[ -f $HOME/.cargo/env ] && source "$HOME/.cargo/env" # Rust
[ -f $HOME/.asdf/asdf.sh ] && source "$HOME/.asdf/asdf.sh" # asdf

# Init oh-my-posh
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
if [[ -d ./zsh-autosuggestions ]]; then
  source ./zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -d /usr/share/zsh-autosuggestions ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Init zoxide if it is installed
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Init asdf if it is installed
if command -v asdf &> /dev/null; then
  fpath=(${ASDF_DIR}/completions $fpath)
fi

### Autocompletion ###
autoload -Uz +X compinit && compinit
