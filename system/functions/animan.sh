#!/bin/bash
# Anime Management Toolbelt
#
# Author:  Denis Luchkin-Zhou <wyvernzora@gmail.com>
#          Siyuan Gao <siyuangao@gmail.com>
# License: MIT

# Set shellopt
shopt -s nullglob
shopt -s nocaseglob

# Constants and expressions
DELIMITER_L="\\[\\( 第"
DELIMITER_R="\\]\\) 話"
REGEX_INDEX="(\\d{2}(?:\\.\\d+)?)(?:v\\d+)?"
REGEX_EXT="\\.([\\w\\d]+)$"

# Rename anime in a folder
BASENAME=$1
if [[ -z $BASENAME ]]; then
  BASENAME=${PWD##*/};
fi
REGEX=".*(?:[$DELIMITER_L])$REGEX_INDEX(?:[$DELIMITER_R]).*$REGEX_EXT"
REPLACE=$BASENAME" \$1.\$2"

function dry-run() {
  printf "%s\t→\t%s\n" "$1" "$2"
}

function move() {
  mv "$1" "$2"
}

function scan() {
  for file in *.{mp4,mkv,ass}; do
    NEWNAME=$(printf "%s\n" "$file" | perl -pe "s/$REGEX/$REPLACE/g")
    ($1 "$file" "$NEWNAME")
  done
}

scan dry-run

echo
echo " - Press [Enter] to rename, [Ctrl-C] to cancel"
read -n 1

scan move

echo
echo " - Complete!"

# Unset shellopt
shopt -u nullglob
shopt -u nocaseglob
