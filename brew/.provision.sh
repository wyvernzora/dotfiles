#
# brew/provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'brew-provision'
bb-task-def 'brew-install'
bb-task-def 'brew-packages'
bb-task-def 'brew-casks'
bb-task-def 'brew-taps'


brew-provision() {
  bb-task-depends 'brew-install' 'brew-taps' 'brew-packages' 'brew-casks'
}


#
# Install brew
#
brew-install() {
  bb-task-depends 'git-install'


  # Skip if already available
  if bb-exe? "brew"; then
    brew update &> /dev/null
    bb-log-misc "Brew updated to the latest version"
    return
  fi


  # macOS
  if is-platform? 'darwin'; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


  # linux
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"


  fi
}


#
# Install brew taps
#
brew-taps() {
  bb-task-depends 'brew-install'

  while read tap; do
    if ! bb-brew-repo? "$tap"; then
      brew tap "$tap" &> /dev/null;
      bb-log-misc "Tapped ${tap}"
    else
      bb-log-misc "Skipped ${tap}"
    fi
  done < brew/taps.txt;

}



#
# Install brew packages
#
brew-packages() {

  bb-task-depends 'brew-taps'

  while read pkg; do

    #
    # Get the actual package name
    #
    name=$(first_arg $pkg)

    if ! bb-brew-package? "$name"; then
      #
      # No quotes around $pkg here since packages may have additional arguments
      #
      brew install $pkg &> /dev/null
      bb-log-misc "Installed ${pkg}"
    else
      bb-log-misc "Skipped ${pkg}"
    fi
  done < brew/packages.txt;

}



#
# TODO Install cask packages
#
brew-casks() {

  bb-task-depends 'brew-packages'

}
