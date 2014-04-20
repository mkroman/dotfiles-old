# Shell options.
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt nobeep
setopt prompt_subst

# Shell modules.
autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Environment variables.
export HISTFILE=~/.history
export HISTSIZE=1000
export SAVEHIST=1000
export BROWSER=chromium
export EDITOR=vim

# Key bindings.
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
bindkey '^R' history-incremental-search-backward

# Load rbenv.
if [ -e ~/.rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"

  eval "$(rbenv init -)"
fi

# Load dir colors.
if [ -e ~/.dircolors ]; then
  eval "$(dircolors)"
fi
