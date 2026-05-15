# ~/.zprofile - login-shell adjustments after macOS path_helper.
#
# /etc/zprofile runs /usr/libexec/path_helper for login shells, which orders
# /usr/local/bin before /opt/homebrew/bin. Move Homebrew back to the front so
# Apple Silicon Homebrew tools win over Docker Desktop shims in /usr/local/bin.
if [ -d /opt/homebrew ]; then
    export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
    export HOMEBREW_CELLAR="${HOMEBREW_CELLAR:-$HOMEBREW_PREFIX/Cellar}"
    export HOMEBREW_REPOSITORY="${HOMEBREW_REPOSITORY:-$HOMEBREW_PREFIX}"

    path_prepend_login() {
        local dir="$1"
        [ -d "$dir" ] || return

        PATH=":${PATH}:"
        PATH="${PATH//:$dir:/:}"
        PATH="${PATH#:}"
        PATH="${PATH%:}"
        export PATH="$dir${PATH:+:$PATH}"
    }

    path_prepend_login "$HOMEBREW_PREFIX/sbin"
    path_prepend_login "$HOMEBREW_PREFIX/bin"
    unfunction path_prepend_login
fi

[ -r "$HOME/.zprofile.local" ] && source "$HOME/.zprofile.local"
