#
# nodejs/.onload.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#



#
# Environment variables
#

# Setup PATH to include npm global modules and local npm executables
export PATH="/usr/local/heroku/bin:$HOME/.npm/bin:./node_modules/.bin:$PATH"

# Setup NODE_PATH to be able to require globally installed modules
export NODE_PATH="$HOME/.npm/lib/node_modules"

# Setup MANPATH to include npm global modules
export MANPATH="$HOME/.npm/share/man:$MANPATH"

# If I use these dotfiles, most likely this is a development machine
export NODE_ENV="development"

# Set n prefix and add node binaries to path
export N_PREFIX="$HOME/n";
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"



#
# npm shortcuts
#

alias npm-i='npm install --save'
alias npm-d='npm install --save-dev'
alias npm-g='npm install --global'
alias nrd='npm run dev'
