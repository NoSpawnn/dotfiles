#
#
# ONLY WORKS ON ARCH-BASED DISTRIBUTIONS (curently)
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### Install functions ###
install_zshautosuggestions() {
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
}

install_zoxide() {
  sudo pacman -S --noconfirm zoxide
  eval "$(zoxide init zsh)"
}

install_spicetify() {
  sudo pacman -S --noconfirm spicetify-cli
  export PATH=$PATH:$HOME/.spicetify
}

install_asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
  source "$HOME/.asdf/asdf.sh"
}

### Aliases ###
alias ls="ls --color=auto"
alias grep='grep --color=auto'
[ -f /usr/bin/bat ] && alias cat="bat"
[ -f /usr/bin/eza ] && alias ls="eza -al"

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
[ -d $HOME/.cargo ] && source "$HOME/.cargo/env" # Rust
[ -f $HOME/.asdf/asdf.sh ] && source "$HOME/.asdf/asdf.sh" # asdf

# Init oh-my-posh
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
if [[ ! -d ~/.zsh/zsh-autosuggestions ]]; then
  echo "zsh-autosuggestions is not installed. Install it? [y/N]: "
  read -r ans

  if [[ "$ans" == "y" ]]; then
    install_zshautosuggestions
  fi
else
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Init zoxide if it is installed
if ! command -v zoxide &> /dev/null; then
  echo "zoxide is not installed. Install it? [y/N]: "
  read -r ans

  if [[ "$ans" == "y" ]]; then
    install_zoxide
  fi
else
  eval "$(zoxide init zsh)"
fi

# Init zoxide if it is installed
if ! command -v asdf &> /dev/null; then
  echo "asdf-vm is not installed. Install it? [y/N]: "
  read -r ans

  if [[ "$ans" == "y" ]]; then
    install_asdf
  fi
else
  source "$HOME/.asdf/asdf.sh"
fi

export PATH=$PATH:/home/adam/.spicetify

### Autocompletion ###
autoload -Uz +X compinit && compinit