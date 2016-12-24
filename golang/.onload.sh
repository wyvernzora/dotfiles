#
# nodejs/.onload.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Environment variables
#

# Path where Go installs packages
export GOPATH="$HOME/.go"

# Make sure we can execute those binaries
export PATH="$PATH:$GOPATH/bin"
