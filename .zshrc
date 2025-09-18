# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### Functions ###

_command_exists() {
    command -v "$1" &> /dev/null
}

### Opts ###
setopt COMPLETE_ALIASES

### Aliases ###
alias grep="grep --color=auto"
alias ls="ls -a --color=auto"
if command -v bat &> /dev/null; then
    alias cat="bat";
    alias rcat="bat --style=plain" # Raw cat
fi
if command -v eza &> /dev/null; then
    alias ls="eza -hl --icons=auto"
    alias ll="eza -hla --icons=auto"
    alias l.="eza -hl -d .* --icons=auto 2> /dev/null || true" # Suppressing the error code when no matches are found, there's probably a more robust way to do this
fi
if command -v nvim &> /dev/null; then alias vim="nvim"; fi
if command -v flatpak &> /dev/null; then
    flatpak list --user --app | grep -q "dev.zed.Zed" && alias zed="flatpak run --user dev.zed.Zed"
fi

### Binds ###
# List functions with `print -l ${(ok)functions}`
bindkey "^[[3~" delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^H" backward-delete-word
bindkey "^[[3;5~" delete-word
bindkey "^I" menu-complete
bindkey "^[[Z" reverse-menu-complete
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

### History ###
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups
setopt SHARE_HISTORY

### Case-insensitive path-completion ###
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

### Exports ###
if [[ "$DEVPOD" != "true" ]]; then
    export PATH=$PATH:$HOME/.local/bin
    export EDITOR=vim
    export SSH_AUTH_SOCK=$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock
fi

### Envs ###
[ -f $HOME/.cargo/env ] && source "$HOME/.cargo/env" # Rust
[ -f $HOME/.asdf/asdf.sh ] && source "$HOME/.asdf/asdf.sh" # asdf

# Init oh-my-posh
if _command_exists oh-my-posh; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
if [[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -d /usr/share/zsh-autosuggestions ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Init zoxide if it is installed
if _command_exists zoxide; then
  eval "$(zoxide init zsh)"
fi

# Init asdf if it is installed
if _command_exists asdf; then
  fpath=(${ASDF_DIR}/completions $fpath)
fi

### Autocompletion ###
autoload -Uz +X compinit && compinit

if _command_exists devpod; then
    source <(devpod completion zsh)
fi
