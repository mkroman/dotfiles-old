# Lines configured by zsh-newuser-install
zstyle :compinstall filename '${HOME}/.zshrc'

# Options
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd

# Modules
autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -U promptinit && promptinit

# Variables
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export BROWSER=chromium
export EDITOR=vim
export PS1="%{$fg[cyan]%}%n@%m%b%{$fg[normal]%} %~ %# "
export PATH="$PATH:$HOME/.bin:/usr/local/bin"


if [ -f /opt/GNUstep/System/Library/Makefiles/GNUstep.sh ]; then
  . /opt/GNUstep/System/Library/Makefiles/GNUstep.sh
fi

# Completion settings
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

# Key bindings
# General aliases
#alias vim="TERM=screen-256color vim"
alias mb="~/.bin/metabox"
alias up="~/.bin/metabox"
alias ls="ls --color -F"
alias irb='irb --simple-prompt -rirb/completion'
alias mail="mailx"
alias packer="packer --noedit"

# Extensions
alias -s jpg="mirage"

# Git aliases
alias gush="git push"
alias gushh="git push origin master"
alias gash="git stash"
alias gasha="git stash apply"
alias gush="git push"
alias gushh="git push origin master"
alias gul="git pull"
alias gull="git pull origin master"

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

function uplink-play() {
  ssh maero.dk "unrar p -inul ~/.rtorrent/downloads/$1/*.rar" | mplayer -idx -
}

function fuck-vpn() {
  sudo ip route flush table main && sudo /etc/rc.d/network restart
}

function start-vpn() {
  sudo openconnect --script=/etc/vpnc/vpnc-script signon1.beevpn.com
}
