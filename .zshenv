# ~/.zshenv - environment shared by all zsh invocations.
# Keep this file fast and side-effect free; it runs for every subshell.
#
# Required setup on a fresh machine:
#
#   1. Install Homebrew
#        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
#   2. Install mise
#        brew install mise
#
#   3. Install GNU userland
#        brew install coreutils findutils gnu-sed gnu-tar grep gawk diffutils make gnu-getopt
#
# Open a new shell after each step to pick up PATH changes. Missing dirs are
# silently skipped by path_prepend below, so partial installs are safe.

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

path_prepend() {
    local dir="$1"
    [ -d "$dir" ] || return

    PATH=":${PATH}:"
    PATH="${PATH//:$dir:/:}"
    PATH="${PATH#:}"
    PATH="${PATH%:}"
    export PATH="$dir${PATH:+:$PATH}"
}

path_prepend "$HOME/Library/Python/3.x/bin"
path_prepend "$HOME/go/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$XDG_DATA_HOME/mise/shims"

if [ -d /opt/homebrew ]; then
    export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
    export HOMEBREW_CELLAR="${HOMEBREW_CELLAR:-$HOMEBREW_PREFIX/Cellar}"
    export HOMEBREW_REPOSITORY="${HOMEBREW_REPOSITORY:-$HOMEBREW_PREFIX}"
    path_prepend "$HOMEBREW_PREFIX/sbin"
    path_prepend "$HOMEBREW_PREFIX/bin"
fi

unfunction path_prepend

[ -r "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
