# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### Opts ###
setopt COMPLETE_ALIASES

### Aliases ###
alias grep="grep --color=auto"
alias ls="ls -a --color=auto"
if command -v bat &> /dev/null; then alias cat="bat"; fi
if command -v eza &> /dev/null; then alias ls="eza -al"; fi
if command -v nvim &> /dev/null; then alias vim="nvim"; fi
flatpak list --user --app | grep -q "dev.zed.Zed" && alias zed="flatpak run --user dev.zed.Zed"

### Binds ###
bindkey "^[[3~" delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

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
export EDITOR=vim
export SSH_AUTH_SOCK=$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock

### Envs ###
[ -f $HOME/.cargo/env ] && source "$HOME/.cargo/env" # Rust
[ -f $HOME/.asdf/asdf.sh ] && source "$HOME/.asdf/asdf.sh" # asdf

# Init oh-my-posh
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
if [[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
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
