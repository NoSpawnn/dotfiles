#
#
# ONLY WORKS ON ARCH-BASED DISTRIBUTIONS (curently)
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls="ls --color=auto"
alias grep='grep --color=auto'
[ -f /usr/bin/bat ] && alias cat="bat"
[ -f /usr/bin/eza ] && alias ls="eza -al"

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt histignorealldups
setopt SHARE_HISTORY

# Autocompletion
autoload -Uz +X compinit && compinit

# Case-insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

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

# Rust env
[ -d $HOME/.cargo ] && source "$HOME/.cargo/env"

# asdf-vm
[ -f /opt/asdf-vm/asdf.sh ] && source /opt/asdf-vm/asdf.sh

# Init oh-my-posh
[ -f /usr/local/bin/oh-my-posh ] && eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# Autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
if [[ ! -d ~/.zsh/zsh-autosuggestions ]]; then
  echo "zsh-autosuggestions is not installed. Install it? [y/n]: "
  read -r ans

  if [[ "$ans" == "y" ]]; then
    install_zshautosuggestions
  fi
else
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# NOT TESTED
# pacman -Q spicetify-cli &>/dev/null
# if [[ "$?" -eq 1 ]]; then
#   echo "spicetify is not installed. Install it? [y/n]: "
#   read -r ans

#   if [[ "$ans" == "y" ]]; then
#     install_spicetify
#   fi
# else
#   export PATH=$PATH:$HOME/.spicetify
# fi

# Init spicetify-cli if it is installed
export PATH=$PATH:$HOME/.spicetify

# Init zoxide if it is installed
pacman -Q zoxide &>/dev/null
if [[ "$?" -eq 1 ]]; then
  echo "zoxide is not installed. Install it? [y/n]: "
  read -r ans

  if [[ "$ans" == "y" ]]; then
    install_zoxide
  fi
else
  eval "$(zoxide init zsh)"
fi
