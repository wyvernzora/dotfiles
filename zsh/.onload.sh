#
# zsh/onload.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#



#
# Initialize antibody and load bundles
#
source <(antibody init)
antibody bundle < "${DOT_ROOT}/zsh/bundles.txt"



#
# Add each topic folder to FPATH
#
for topic_folder in $DOT_ROOT/*; do
  if [ -d $topic_folder ]; then
    fpath=($topic_folder $fpath)
  fi
done



#
# Aliases
#

# Reloads the .zshrc file
alias reload!='. ~/.zshrc'

# Updates the .dotfiles
alias update!='(cd $DOT_ROOT > /dev/null; git pull;); reload!'

# Fix sudo + alias bug
alias sudo='sudo '



#
# Initialize auto-completion system
#
autoload -U compinit
compinit


#
# Load completion files
#
for completion in $(find -H "${DOT_ROOT}" -maxdepth 2 -name '.completion.sh'); do
  source "$completion"
done



#
# Other utilities
#
source ${DOT_ROOT}/zsh/window.sh
