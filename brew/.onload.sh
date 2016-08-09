#
# brew/.onload.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Initialize direnv hook
#
if type "direnv" > /dev/null; then
  eval "$(direnv hook zsh)"
fi
