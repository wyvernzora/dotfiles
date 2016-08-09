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
# Load the platform utility
#
source $HOME/.dotfiles/provision/util/u-platform.sh


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
$HOME/.dotfiles/provision/start.sh;
