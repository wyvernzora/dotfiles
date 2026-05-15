# ~/.zshrc - interactive shell setup. Environment and PATH live in ~/.zshenv.
#
# Required setup on a fresh machine:
#
#   1. Install required binaries
#        brew install starship zoxide direnv fzf
#          - starship : prompt. Needs a Nerd Font in your terminal.
#          - zoxide   : smarter cd; used as `cd` via `--cmd cd` below.
#          - direnv   : per-directory .envrc loading.
#          - fzf      : fuzzy finder; required by the fzf-tab plugin below.
#
#   2. zinit auto-installs on first shell launch.
#
#   3. Optional: enable fzf's Ctrl-R / Ctrl-T / Alt-C key bindings
#        "$(brew --prefix)/opt/fzf/install"

# Set up zinit.
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Set up plugins.
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

# Autocompletion.
[[ -d "${XDG_CACHE_HOME}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME}/zsh"
autoload -U compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Key bindings.
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# History.
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases.
alias c='clear'
alias ls='ls --color'
alias ..='cd ..'
alias ...='cd ../..'

# Additional initializations.
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
