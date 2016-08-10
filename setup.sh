#!/bin/bash
#
# install
#
# @author  Siyuan Gao <siyuangao@gmail.com>
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# DOT_ROOT?
#
DOT_ROOT=${DOR_ROOT:-"$HOME/.dotfiles"}



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
if [ -d $DOT_ROOT ]; then
  (
    cd $DOT_ROOT;
    git pull;
  )
else
  git clone https://github.com/jluchiji/dotfiles $DOT_ROOT
fi


#
# Load the platform utility
#
source $DOT_ROOT/.provision/u-platform.sh


#
# Update bash to at least v4
#
if is-platform? 'darwin'; then

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install bash

elif is-platform? 'centos'; then

  yum update bash

elif is-platform? 'debian'; then

  apt-get update
  apt-get install --only-upgrade bash

fi


#
# Run the provisioner
#
$DOT_ROOT/.provision/start;
