# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### Utility functions ###

_command_exists() {
    command -v "$1" &> /dev/null
}

### Source global definitions ###
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

### Envs/Path/Other exports ###
PATH="$PATH:$HOME/.local/bin"

if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
    PATH=$PATH:$HOME/.cargo/bin
fi

if [ -d "$HOME/.spicetify" ]; then
    PATH=$PATH:$HOME/.spicetify
fi

if [[ "$DEVPOD" != "true" ]]; then
    export EDITOR=vim
    export SSH_AUTH_SOCK=$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock
fi

if _command_exists asdf; then
    PATH="$PATH:${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
    source <(asdf completion bash)
fi

if _command_exists fzf; then
    eval "$(fzf --bash)"

    if _command_exists fd; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
    fi
fi
export PATH
export HISTCONTROL=ignoreboth:erasedups

### Aliases ###
alias yust="just --justfile=\"\$HOME/.user.justfile\" --working-directory=\".\""
alias grep="grep --color=auto"
alias ls="ls -a --color=auto"
if _command_exists bat &> /dev/null; then
    alias cat="bat";
    alias rcat="bat --style=plain" # Raw cat
fi
if _command_exists eza &> /dev/null; then
    alias ls="eza -hl --icons=auto"
    alias ll="eza -hla --icons=auto"
    alias l.="eza -hl -d .* --icons=auto 2> /dev/null || true" # Suppressing the error code when no matches are found, there's probably a more robust way to do this
fi
if _command_exists nvim &> /dev/null; then alias vim="nvim"; fi
if _command_exists flatpak &> /dev/null; then
    flatpak list --app | grep -q "dev.zed.Zed" && alias zed="flatpak run dev.zed.Zed"
fi
alias e="echo" # This is nice
if _command_exists lazygit; then
    alias lg="lazygit"
fi

if _command_exists oh-my-posh; then
    eval "$(oh-my-posh init bash --config "$HOME/.config/ohmyposh/config.toml")"
fi

if _command_exists starship; then
    eval "$(starship init bash)"
fi

if _command_exists zoxide; then
    eval "$(zoxide init bash)"
fi

### Completion ###
if _command_exists devpod; then
    source <(devpod completion bash)
fi

if _command_exists kubectl; then
    source <(kubectl completion bash)
fi

if _command_exists aws && _command_exists aws_completer; then
    complete -C '$(which aws_completer)' aws
fi

if _command_exists eksctl; then
    source <(eksctl completion bash)
fi

if [[ -f /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh ]]; then
    source /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
fi

export PATH=$PATH:/home/red/.spicetify
