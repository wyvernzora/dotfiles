# Loaded by interactive shells.

[[ $- != *i* ]] && return

HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=50000

setopt append_history
setopt auto_cd
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

autoload -Uz compinit
compinit

autoload -Uz colors
colors

dotfiles_dir="${${(%):-%x}:A:h}"

PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '

alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias ll='ls -lah'

[ -r "$dotfiles_dir/zsh/aliases.zsh" ] && source "$dotfiles_dir/zsh/aliases.zsh"
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
