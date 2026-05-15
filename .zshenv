# Loaded by every zsh process. Keep this file fast, quiet, and portable.

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  $path
)

[ -r "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
