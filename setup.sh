#!/bin/bash
#
# install
#
# @author  Siyuan Gao <siyuangao@gmail.com>
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Detect git installation
#
if ! type "git" > /dev/null; then
  echo "Please install git before provisioning"
  exit 1
fi



#
# Clone or pull depending on situation
#
if [[ -d $HOME/.dotfiles ]]; then
  (
    cd $HOME/.dotfiles;
    git pull;
  )
else
  git clone https://github.com/jluchiji/dotfiles $HOME/.dotfiles
fi


#
# Update bash to at least v4
#
platform=$(uname | tr "[:upper:]" "[:lower:]")
if [ "$platform" = "darwin" ]; then

  # So we end up installing brew on MacOS
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Update bash
  brew install bash

else

  # yum -> centos
  if type "yum" > /dev/null; then
    yum update bash
  fi

  # apt-get -> debian
  if type "apt-get" > /dev/null; then
    apt-get update
    apt-get install --only-upgrade bash
  fi

fi



#
# Run the provisioner
#
$HOME/.dotfiles/provision/start.sh;
