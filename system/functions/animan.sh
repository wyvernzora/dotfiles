#
# Anime Management Toolbelt
#
# Author:  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# License: MIT

# TODO Install dependencies
if [[ -n $(type foo >/dev/null 2>&1) ]]; then
  npm install --global renamer
fi

# Constants and expressions
DELIMITER_L="\[\( 第"
DELIMITER_R="\]\) 話"
REGEX_INDEX="(\d{2}(?:\.\d+)?)(?:v\d+)?"
REGEX_EXT="\.([\w\d]+)$"

# Rename anime in a folder
aniren() {
  BASENAME=$1
  if [[ -z $BASENAME ]]; then
    BASENAME=$(cwd);
  fi
  REGEX=".*(?:[$DELIMITER_L])$REGEX_INDEX(?:[$DELIMITER_R]).*$REGEX_EXT"
  REPLACE=$BASENAME"[\$1].\$2"
  renamer -e -f "$REGEX" -r "$REPLACE" --dry-run "*.{mp4,mkv,ass}"

  echo
  echo " - Press [Enter] to rename, [Ctrl-C] to cancel"
  read -n 1

  renamer -e -f "$REGEX" -r "$REPLACE" "*.{mp4,mkv,ass}" > /dev/null

  echo
  echo " - Complete!"
}
