#
# system/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Setup PATH
#
export PATH="./bin:$DOT_ROOT/system/bin:$PATH"
export MANPATH="$MANPATH"


#
# Preferred editor for local and remote sessions
#
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='atom'
fi


#
# Aliases
#


#
# Preferred file manipulation utilities
#
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls -G'                            # Preferred 'ls' implementations
alias ll='ls -FGlAhp'
alias la='ls -aG'


#
# Changing working directory
#
cd() { builtin cd "$@"; ls; }               # Always list contents upon 'cd'
alias ~="cd ~"                              # ~: Go Home
alias cd..='cd ../'                         # Go back 1 directory level
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels


#
# Various other stuff
#
alias c='clear'                             # Clear terminal
alias cwd='basename "$(pwd)" | tr -d "\n"'  # Copy current working directory
alias path='echo -e ${PATH//:/\\n}'         # Echo all executable Paths



#
# Load additional utilities
#
for func in $(find -H "${DOT_ROOT}/system/functions" -maxdepth 2 -name '*.sh'); do
  source "$func"
done
