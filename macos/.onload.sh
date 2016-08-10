#
# macos/.onload.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Clipboard-aware navigation helpers
#

# Copies the basename of current working directory to the clipboard
cpwd() {
  basename "$(pwd)" | tr -d '\n' | pbcopy
  echo ">> Directory name copied."
}

# Copies the path of current working directory to clipboard
cpath() {
  pwd | tr -d '\n' | pbcopy
  echo ">> Directory path copied."
}

# Goes to the directory whose path is in the clipboard
ccd() {
  cd "$(pbpaste)"
}

# Exports the directory in the clipboard to PATH
cexp() {
  export PATH="$(pbpaste):$PATH";
}
